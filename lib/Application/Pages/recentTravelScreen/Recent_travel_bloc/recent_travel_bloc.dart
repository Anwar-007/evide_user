import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_travel_event.dart';
part 'recent_travel_state.dart';

class RecentTravelBloc extends Bloc<RecentTravelEvent, RecentTravelState> {
  RecentTravelBloc() : super(RecentTravelInitial()) {
    on<RecentTravelEvent>((event, emit) {
   
    });
  }
}
