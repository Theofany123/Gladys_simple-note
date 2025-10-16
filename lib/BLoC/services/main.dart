import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/note_repository.dart';
import '../add_note/add_note_bloc.dart';
import '../note_list/note_list_event.dart';
import '../note_list/note_list_bloc.dart';
import '../add_note/add_note_event.dart';
import '../note_list/note_list_state.dart';
import '../update_note/update_note_bloc.dart';
import '../update_note/update_note_event.dart';
import '../selection/selection_bloc.dart';

void main() {
  final noteRepository = NoteRepository();
  runApp(MyApp(noteRepository: noteRepository));
}

class MyApp extends StatelessWidget {
  final NoteRepository noteRepository;
  const MyApp({required this.noteRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NoteListBloc(noteRepository)),
        BlocProvider(create: (_) => AddNoteBloc(noteRepository)),
        BlocProvider(create: (_) => UpdateNoteBloc(noteRepository)),
        BlocProvider(create: (_) => SelectionBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        home: NoteListScreen(),
      ),
    );
  }
}

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NoteListBloc>().add(LoadNotes());

    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, state) {
          if (state is NoteListLoaded) {
            final notes = state.notes;
            if (notes.isEmpty) {
              return const Center(child: Text("No notes yet"));
            }
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, i) {
                final note = notes[i];
                return ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['body']),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateNoteScreen(note: note),
                      ),
                    );
                    context.read<NoteListBloc>().add(LoadNotes());
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNoteScreen()),
          );
          context.read<NoteListBloc>().add(LoadNotes());
        },
      ),
    );
  }
}

class AddNoteScreen extends StatefulWidget {
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title")),
            TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Content")),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                context.read<AddNoteBloc>().add(
                      AddNoteButtonPressed(
                        titleController.text,
                        bodyController.text,
                      ),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateNoteScreen extends StatefulWidget {
  final Map<String, dynamic> note;
  const UpdateNoteScreen({required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note['title']);
    bodyController = TextEditingController(text: widget.note['body']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title")),
            TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Content")),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                context.read<UpdateNoteBloc>().add(
                      UpdateNoteButtonPressed(
                        widget.note['id'],
                        titleController.text,
                        bodyController.text,
                      ),
                    );
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                context.read<UpdateNoteBloc>().add(
                      DeleteNoteButtonPressed(widget.note['id']),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
