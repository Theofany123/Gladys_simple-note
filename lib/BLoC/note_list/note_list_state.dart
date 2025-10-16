abstract class NoteListState {}

class NoteListLoading extends NoteListState {}

class NoteListLoaded extends NoteListState {
  final List<Map<String, dynamic>> notes;
  NoteListLoaded(this.notes);
}
