import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _pollingTimer;

  TimelineBloc() : super(TimelineInitial()) {
    on<LoadBusData>(_onLoadBusData);
    on<StopPolling>(_onStopPolling);
    on<UpdateTripData>(_onUpdateTripData);
  }

  Future<void> _onLoadBusData(LoadBusData event, Emitter<TimelineState> emit) async {
    emit(TimelineLoading());

    try {
      // Step 1: Check if busNumber exists
      final tripSnapshot = await _firestore
          .collectionGroup('BusDetails')
          .where('busNumber', isEqualTo: event.busNumber)
          .get();

      if (tripSnapshot.docs.isEmpty) {
        emit(TimelineError('Bus number ${event.busNumber} not found.'));
        return;
      }

      // Step 2: Search across the subcollection Trips for startTime and endTime
      for (var busDoc in tripSnapshot.docs) {
        final tripsRef = busDoc.reference.collection('Trips');
        final tripsSnapshot = await tripsRef
            .where('startTime', isEqualTo: event.startTime)
            .where('endTime', isEqualTo: event.endTime)
            .get();

        if (tripsSnapshot.docs.isNotEmpty) {
          final tripData = tripsSnapshot.docs.first.data();

          // Step 3: Check LiveTime in parent collection
          final liveLocations = busDoc.data()['LiveLocation'] as List<dynamic>? ?? [];
          final liveTimeStr = liveLocations.isNotEmpty
              ? liveLocations.last['LiveTime'] as String?
              : null;

          final dateFormat = DateFormat('hh:mm a');
          DateTime? liveTime, startTime, endTime;

          if (liveTimeStr != null) {
            liveTime = dateFormat.parse(liveTimeStr);
          }
          startTime = dateFormat.parse(tripData['startTime']);
          endTime = dateFormat.parse(tripData['endTime']);

          int currentStopIndex = 0;
          List<dynamic>? arrivedTime;

          if (liveTime != null && liveTime.isAfter(startTime) && liveTime.isBefore(endTime)) {
            // If LiveTime is within range
            currentStopIndex = tripData['currentStopIndex'] ?? 0;
            arrivedTime = tripData['arrivedTime'] as List<dynamic>?;
          }

          // Start polling if the trip is live
          _startPolling(tripsSnapshot.docs.first.reference);

          // Pass data to UI
          emit(TimelineLoaded({
            ...tripData,
            'currentStopIndex': currentStopIndex,
            'arrivedTime': arrivedTime,
          }));
          return;
        }
      }

      emit(TimelineError('No matching trip found.'));
    } catch (e) {
      emit(TimelineError('Error loading trip data: ${e.toString()}'));
    }
  }

  Future<void> _onStopPolling(StopPolling event, Emitter<TimelineState> emit) async {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void _startPolling(DocumentReference tripRef) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        final tripSnapshot = await tripRef.get();
        if (tripSnapshot.exists) {
          final updatedData = tripSnapshot.data() as Map<String, dynamic>;
          add(UpdateTripData(updatedData));
        }
      } catch (e) {
        // Log polling errors if needed
      }
    });
  }

  void _onUpdateTripData(UpdateTripData event, Emitter<TimelineState> emit) {
    emit(TimelineLoaded(event.updatedData)); // Send updated data back to the UI
  
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
