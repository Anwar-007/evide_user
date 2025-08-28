part of 'search_box_bloc.dart';

sealed class SearchBoxEvent extends Equatable {
  const SearchBoxEvent();

  @override
  List<Object> get props => [];
}
class PerformSearchEvent extends SearchBoxEvent{
  final String from;
  final String destination;
  final String searchTime;

  const PerformSearchEvent({required this.from, required this.destination, required this.searchTime,});
}
class SearchSuggestionsEvent extends SearchBoxEvent {
  final String query;

  const SearchSuggestionsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchClear extends SearchBoxEvent {}