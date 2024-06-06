import 'package:counterbloc/visibility_blocs/bloc/visibility_event.dart';
import 'package:counterbloc/visibility_blocs/bloc/visibility_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityState()) {
    on<VisibilityShowEvent>((event, emit) {
      emit(VisibilityState(show: true));
    });
    on<VisibilityHideEvent>((event, emit) {
      emit(VisibilityState(show: false));
    });
  }
}
