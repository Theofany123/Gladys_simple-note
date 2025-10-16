class NoteRepository {
  // Simulasi database lokal sementara
  final List<Map<String, dynamic>> _notes = [];

  Future<List<Map<String, dynamic>>> getNotes() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulasi loading
    return List<Map<String, dynamic>>.from(_notes);
  }

  Future<void> addNote(Map<String, dynamic> note) async {
    await Future.delayed(const Duration(milliseconds: 300));
    note['id'] = DateTime.now().millisecondsSinceEpoch;
    _notes.add(note);
  }

  Future<void> updateNote(int id, Map<String, dynamic> newNote) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _notes.indexWhere((n) => n['id'] == id);
    if (index != -1) {
      _notes[index] = {..._notes[index], ...newNote};
    }
  }

  Future<void> deleteNote(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _notes.removeWhere((n) => n['id'] == id);
  }
}
