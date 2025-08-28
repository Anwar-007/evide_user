import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SearchResultBloc() : super(SearchResultInitial()) {
    on<FetchLiveLocation>((event, emit) async {
      try {
        final snapshot = await firestore.collection('contactnumber').get();

        if (snapshot.docs.isNotEmpty) {
          final String number = snapshot.docs.first.get('Phone');
          emit(PhonenumberLoaded(phoneNumber: number));
        } else {
          emit(LiveLocationError(error: 'No phone number found in Firestore.'));
        }
      } catch (e) {
        emit(LiveLocationError(error: e.toString()));
      }
    });
  }
}
