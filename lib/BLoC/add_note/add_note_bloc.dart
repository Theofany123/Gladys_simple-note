import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/note_repository.dart';
import 'add_note_event.dart';
import 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteRepository noteRepository;

  AddNoteBloc(this.noteRepository) : super(AddNoteInitial()) {
    on<AddNoteButtonPressed>((event, emit) {
      noteRepository.addNote({'title': event.title, 'body': event.body});
      emit(AddNoteSuccess());
    });
  }
}
