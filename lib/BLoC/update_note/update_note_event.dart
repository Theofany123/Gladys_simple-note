abstract class UpdateNoteEvent {}

class UpdateNoteButtonPressed extends UpdateNoteEvent {
  final int id;
  final String title;
  final String body;

  UpdateNoteButtonPressed(this.id, this.title, this.body);
}

class DeleteNoteButtonPressed extends UpdateNoteEvent {
  final int id;
  DeleteNoteButtonPressed(this.id);
}
