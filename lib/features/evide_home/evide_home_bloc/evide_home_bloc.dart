import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'evide_home_event.dart';
part 'evide_home_state.dart';

class EvideHomeBloc extends Bloc<EvideHomeEvent, EvideHomeState> {
  EvideHomeBloc() : super(EvideHomeInitial()) {
    on<EvideHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
