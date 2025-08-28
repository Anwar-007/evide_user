part of 'recent_travel_bloc.dart';

sealed class RecentTravelState extends Equatable {
  const RecentTravelState();
  
  @override
  List<Object> get props => [];
}

final class RecentTravelInitial extends RecentTravelState {}
