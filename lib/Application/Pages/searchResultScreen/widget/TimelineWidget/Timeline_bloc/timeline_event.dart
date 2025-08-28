part of 'timeline_bloc.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object?> get props => [];
}

class LoadBusData extends TimelineEvent {
  final String busNumber;
  final String? startTime;
  final String? endTime;

  const LoadBusData(this.busNumber, this.startTime, this.endTime);

  @override
  List<Object?> get props => [busNumber, startTime, endTime];
}

class StopPolling extends TimelineEvent {}

class UpdateTripData extends TimelineEvent {
  final Map<String, dynamic> updatedData;

  const UpdateTripData(this.updatedData);

  @override
  List<Object?> get props => [updatedData];
}
