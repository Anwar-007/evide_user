part of 'user_home_bloc.dart';

sealed class UserHomeEvent extends Equatable {
  const UserHomeEvent();

  @override
  List<Object?> get props => [];
}

final class SaveVoteEvent extends UserHomeEvent {
  final String collectionName;
  final String name;
  final String email;
  final String vote;

  const SaveVoteEvent({
    required this.collectionName,
    required this.name,
    required this.email,
    required this.vote,
  });

  @override
  List<Object?> get props => [collectionName, name, email, vote];
}
