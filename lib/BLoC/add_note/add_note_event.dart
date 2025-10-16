abstract class AddNoteEvent {}

class AddNoteButtonPressed extends AddNoteEvent {
  final String title;
  final String body;

  AddNoteButtonPressed(this.title, this.body);
}
