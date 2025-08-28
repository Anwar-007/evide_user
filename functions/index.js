const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();
exports.searchStops = functions.https.onCall(async (data, context) => {
  try {
    const stopNames = data.stopNames;
    if (!Array.isArray(stopNames) || stopNames.length === 0) {
      throw new functions.https.HttpsError(
          "invalid-argument",
          "Stop names must be a non-empty array.",
      );
    }

    const lowerCaseStops = stopNames.map((stop) => stop.toLowerCase());
    const matchedDocuments = [];
    const fetchedDocIds = new Set();

    // Generate unique pairs of stop names
    const pairs = [];
    for (let i = 0; i < lowerCaseStops.length; i++) {
      for (let j = i + 1; j < lowerCaseStops.length; j++) {
        pairs.push([lowerCaseStops[i], lowerCaseStops[j]]);
      }
    }

    // Query Firestore for each pair
    for (const pair of pairs) {
      const [stop1, stop2] = pair;

      const snapshot = await db
          .collection("SampleBusStops")
          .where("Routesname", "array-contains", stop1)
          .get();
      console.log("fetched data", snapshot);

      snapshot.forEach((doc) => {
        const docData = doc.data();
        const routesName = docData.Routesname || [];

        // Check if the second stop is in the same document
        if (routesName.includes(stop2) && !fetchedDocIds.has(doc.id)) {
          fetchedDocIds.add(doc.id);
          matchedDocuments.push({id: doc.id, ...docData});
        }
      });
    }

    return {success: true, matchedDocuments};
  } catch (error) {
    console.error("Error searching stops:", error);
    throw new functions.https.HttpsError(
        "internal",
        "Error searching for stops.",
        error.message,
    );
  }
});

// Trigger when a document in the Trips subcollection is created or updated
exports.createReversedTrip = functions.firestore
    .document("buses/{busId}/Trips/{tripId}")
    .onWrite(async (change, context) => {
    // Check if it's a new document or an update
      const tripData = change.after.exists ? change.after.data() : null;

      if (!tripData) {
        console.log("No data found, skipping.");
        return null; // No document found, skip
      }

      // Extract relevant data from the trip
      const routes = tripData.Routes || [];
      const routesName = tripData.Routesname || [];

      // Reverse the data (routes and routesName arrays)
      const reversedRoutes = routes.reverse();
      const reversedRoutesName = routesName.reverse();

      // Create a new trip document for Trips2 with reversed data
      const reversedTripData = {
        ...tripData,
        Routes: reversedRoutes,
        Routesname: reversedRoutesName,
      // You can also adjust other fields if necessary
      };

      // Reference to the Trips2 collection
      const trips2Ref = db.collectiong("buses")
          .doc(context.params.busId) // Same busId as in the original document
          .collection("Trips2")
          .doc(context.params.tripId);

      // Write the reversed trip data to Trips2
      try {
        await trips2Ref.set(reversedTripData);
        console.log(`Reversed trip data created in Trips2 for busId:
         ${context.params.busId},
        tripId: ${context.params.tripId}`);
        return null;
      } catch (error) {
        console.error("Error creating reversed trip in Trips2:", error);
        throw new functions.https.HttpsError("internal",
            "Failed to create reversed trip.", error);
      }
    });
