import 'package:evide_user/Application/Pages/SplashScreen/bloc/splash_event.dart';
import 'package:evide_user/Application/Pages/SplashScreen/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<FetchSponsorImages>(_fetchSponsorImages);
  }

  Future<void> _fetchSponsorImages(
    FetchSponsorImages event, Emitter<SplashState> emit) async {
  try {
    // Fetch documents from the Firestore collection
    QuerySnapshot sponsorDocs =
        await FirebaseFirestore.instance.collection('sponsorcard').get();

    if (sponsorDocs.docs.isEmpty) {
      emit(SplashError('No sponsor documents found.'));
      return;
    }

    List<String> urls = [];
    for (var doc in sponsorDocs.docs) {
      try {
        // Safely access the 'url' field
        String? relativePath = doc['url'] as String?;
        if (relativePath == null || relativePath.isEmpty) {
          print('Skipping document with missing or empty "url" field.');
          continue; // Skip documents with invalid paths
        }

        // Fetch the download URL from Firebase Storage
        String url = await FirebaseStorage.instance.ref(relativePath).getDownloadURL();
        urls.add(url);
        print('Fetched URL: $url');
      } catch (e, stackTrace) {
        print('Error processing document: $e');
        print(stackTrace); // Log detailed error
      }
    }

    if (urls.isEmpty) {
      emit(SplashError('No valid sponsor images found.'));
    } else {
      emit(SponsorImagesLoaded(urls));
    }
  } catch (e, stackTrace) {
    print('Error fetching sponsor images: $e');
    print(stackTrace); // Log detailed error
    emit(SplashError('Error fetching sponsor images: $e'));
    print('Error fetching sponsor images: $e');
  }
}

}
