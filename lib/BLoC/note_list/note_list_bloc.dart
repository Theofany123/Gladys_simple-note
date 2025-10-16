import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/note_repository.dart';
import 'note_list_event.dart';
import 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NoteRepository noteRepository;

  NoteListBloc(this.noteRepository) : super(NoteListLoading()) {
    on<LoadNotes>((event, emit) async {
      final notes = await noteRepository.fetchNotes();
      emit(NoteListLoaded(notes));
    });
  }
}
