part of 'search_box_bloc.dart';

sealed class SearchBoxState extends Equatable {
  const SearchBoxState();
  
  @override
  List<Object> get props => [];
}

final class SearchBoxInitial extends SearchBoxState {}
class SearchLoadingState extends SearchBoxState{}
class SearchSuccessState extends SearchBoxState{
  final List<Map<String, dynamic>> results;

  const SearchSuccessState({required this.results});
}
class SearchErrorState extends SearchBoxState{
  final String message;

  const SearchErrorState({required this.message});
}class SuggestionLoading extends SearchBoxState {}
class SuggestionLoaded extends SearchBoxState {
  final List<String> suggestions;

  const SuggestionLoaded({required this.suggestions});
}
class SearchNotFound extends SearchBoxState {}
class SuggestionError extends SearchBoxState {
  final String message;

  const SuggestionError({required this.message});
}