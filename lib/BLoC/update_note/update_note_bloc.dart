import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/note_repository.dart';
import 'update_note_event.dart';
import 'update_note_state.dart';

class UpdateNoteBloc extends Bloc<UpdateNoteEvent, UpdateNoteState> {
  final NoteRepository noteRepository;

  UpdateNoteBloc(this.noteRepository) : super(UpdateNoteInitial()) {
    on<UpdateNoteButtonPressed>((event, emit) {
      noteRepository
          .updateNote(event.id, {'title': event.title, 'body': event.body});
      emit(UpdateNoteSuccess());
    });

    on<DeleteNoteButtonPressed>((event, emit) {
      noteRepository.deleteNote(event.id);
      emit(DeleteNoteSuccess());
    });
  }
}
