part of 'user_home_bloc.dart';

sealed class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object?> get props => [];
}

final class UserHomeInitial extends UserHomeState {}

final class UserHomeLoadingState extends UserHomeState {}

final class UserHomeVoteSuccessState extends UserHomeState {
  final String message;

  const UserHomeVoteSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

final class UserHomeErrorState extends UserHomeState {
  final String error;

  const UserHomeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
