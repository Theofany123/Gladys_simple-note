import 'package:flutter_bloc/flutter_bloc.dart';
import 'selection_event.dart';
import 'selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionInitial()) {
    on<SelectNote>((event, emit) => emit(SelectionActive(event.id)));
    on<ClearSelection>((event, emit) => emit(SelectionInitial()));
  }
}
