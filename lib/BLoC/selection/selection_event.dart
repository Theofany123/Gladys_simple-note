abstract class SelectionEvent {}

class SelectNote extends SelectionEvent {
  final int id;
  SelectNote(this.id);
}

class ClearSelection extends SelectionEvent {}
