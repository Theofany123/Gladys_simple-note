abstract class SelectionState {}

class SelectionInitial extends SelectionState {}

class SelectionActive extends SelectionState {
  final int selectedId;
  SelectionActive(this.selectedId);
}
