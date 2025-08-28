// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:workmanager/workmanager.dart';

// class SharelivelocationRepo {
//   final String busNumber;
//   bool isTripActive = false;
//   Timer? _timer;

//   SharelivelocationRepo(this.busNumber);

//   /// Save location to Firestore
//   Future<void> saveLocationToFirestore(
//       double latitude, double longitude) async {
//     try {
//       final firestore = FirebaseFirestore.instance;
//       final currentTime = DateTime.now();
//       final formattedTime = DateFormat('hh:mm a').format(currentTime);

//       QuerySnapshot querySnapshot = await firestore
//           .collectionGroup('BusDetails')
//           .where('busNumber', isEqualTo: busNumber)
//           .orderBy('busNumber')
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         await querySnapshot.docs.first.reference.update({
//           'liveLocations': {
//             'latitude': latitude,
//             'longitude': longitude,
//             'timestamp': currentTime.toIso8601String(),
//             'LiveTime': formattedTime,
//           },
//         });
//         print("Live location saved at $formattedTime");
//       } else {
//         print("BusNumber $busNumber not found in Firestore.");
//       }
//     } catch (e) {
//       print("Error saving live location: $e");
//     }
//   }

//   /// Get current location
//   Future<Position> getCurrentLocation() async {
//     if (!await Geolocator.isLocationServiceEnabled()) {
//       throw Exception('Location services are disabled.');
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception('Location permission permanently denied.');
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   /// Start live location updates
//   void startUpdatingLocation() {
//     if (isTripActive) return; // Prevent duplicate timers

//     isTripActive = true;

//     FlutterForegroundTask.startService(
//       notificationTitle: 'Bus Location Service',
//       notificationText: 'Sharing live location updates',
//     );

//     _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
//       try {
//         final position = await getCurrentLocation();
//         saveLocationToFirestore(position.latitude, position.longitude);
//       } catch (e) {
//         print("Error during location update: $e");
//       }
//     });
//     print("Location updates started.");
//   }

//   /// Stop live location updates
//   void stopUpdatingLocation() {
//     _timer?.cancel();
//     FlutterForegroundTask.stopService();
//     isTripActive = false;
//     print("Location updates stopped.");
//   }

//   /// Static: Schedule background location updates
//   static void scheduleBackgroundTask(String busNumber) {
//     Workmanager().registerPeriodicTask(
//       'locationUpdateTask',
//       'locationTask',
//       inputData: {'busNumber': busNumber},
//       frequency: Duration(minutes: 15), // Minimum for iOS
//     );
//     print("Background location updates scheduled.");
//   }

//   /// Static: Cancel background tasks
//   static void cancelBackgroundTask() {
//     Workmanager().cancelByUniqueName('locationUpdateTask');
//     print("Background location updates canceled.");
//   }
// }