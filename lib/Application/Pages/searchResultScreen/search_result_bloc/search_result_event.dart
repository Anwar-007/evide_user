part of 'search_result_bloc.dart';

abstract class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

class FetchLiveLocation extends SearchResultEvent {
 

  const FetchLiveLocation();

  @override
  List<Object> get props => [];
}

class StartFetchingLiveLocation extends SearchResultEvent {
  final String busNumber;

  const StartFetchingLiveLocation({required this.busNumber});

  @override
  List<Object> get props => [busNumber];
}

class StopFetchingLiveLocation extends SearchResultEvent {}