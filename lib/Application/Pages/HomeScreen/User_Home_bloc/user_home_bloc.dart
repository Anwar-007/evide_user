import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInitial()) {
    on<SaveVoteEvent>(_onSaveVote);
  }

  Future<void> _onSaveVote(SaveVoteEvent event, Emitter<UserHomeState> emit) async {
    if (event.name.isEmpty || event.email.isEmpty) {
      emit(UserHomeErrorState("Please fill in all fields."));
      return;
    }

    try {
      emit(UserHomeLoadingState());

      await FirebaseFirestore.instance.collection(event.collectionName).add({
        'name': event.name,
        'email': event.email,
        'vote': event.vote,
        'timestamp': FieldValue.serverTimestamp(),
      });

      emit(UserHomeVoteSuccessState("Your vote has been recorded."));
    } catch (e) {
      emit(UserHomeErrorState("Failed to save vote: $e"));
    }
  }
}
