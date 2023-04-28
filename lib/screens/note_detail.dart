import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/utils/services/notes_list.dart';
import '../models/note.dart';

class NoteDetails extends HookWidget {
  final Note note;
  const NoteDetails({required this.note, super.key});
  @override
  Widget build(BuildContext context) {
    final bodyTextController = useTextEditingController();
    final titleTextController = useTextEditingController();
    final bodyFocus = useFocusNode();
    final titleFocus = useFocusNode();
    bodyTextController.text = note.body;
    titleTextController.text = note.title;
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                padding: const EdgeInsets.all(5),
                onPressed: () {
                  if (note.title != titleTextController.text || note.body != bodyTextController.text) {
                    ref.read(noteStateNotifierProvider.notifier).updateNote(
                        Note(
                          title: titleTextController.text,
                          body: bodyTextController.text,
                          date: note.date,
                          id: note.id,
                          angle: note.angle,
                          color: note.color,
                        ),
                        note.id);
                  }
                },
                icon: const Icon(Icons.save),
              ),
            ],
            centerTitle: true,
            title: EditableText(
              textAlign: TextAlign.center,
              backgroundCursorColor: Colors.black,
              controller: titleTextController,
              cursorColor: Colors.white,
              focusNode: titleFocus,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Card(
                    color: Color(note.color),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: EditableText(
                        maxLines: null,
                        backgroundCursorColor: Colors.black,
                        controller: bodyTextController,
                        cursorColor: Colors.white,
                        focusNode: bodyFocus,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
