part of 'search_result_bloc.dart';

sealed class SearchResultState extends Equatable {
  const SearchResultState();
  
  @override
  List<Object> get props => [];
}

 class SearchResultInitial extends SearchResultState {}
class SearchRestLoading extends SearchResultState{

}
class PhonenumberLoaded extends SearchResultState {
 final String phoneNumber;

  const PhonenumberLoaded({required this.phoneNumber});
}
class LiveLocationError extends SearchResultState{
  final String error;

  const LiveLocationError({required this.error});
}
