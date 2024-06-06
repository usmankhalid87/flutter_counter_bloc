import 'package:counterbloc/blocs/counter_event.dart';
import 'package:counterbloc/blocs/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterIncrementEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });
  }
}
