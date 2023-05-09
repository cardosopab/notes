import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/utils/services/notes_list.dart';
import '../../models/note.dart';
import '../functions/random.dart';

Future<dynamic> addNoteDialog(BuildContext context, WidgetRef ref) {
  return showDialog(
    context: context,
    builder: (context) {
      final titleTextController = TextEditingController();
      final bodyTextController = TextEditingController();
      return AlertDialog(
        title: const Text("Add a Note"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleTextController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 10,
                controller: bodyTextController,
                decoration: const InputDecoration(
                  hintText: 'Body',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              DateTime date = DateTime.now();
              int angle = Random().angleWithin(350, 355);
              int color = Random().color();

              ref.read(noteStateNotifierProvider.notifier).addNote(Note(
                    title: titleTextController.text,
                    body: bodyTextController.text,
                    date: date,
                    id: date.toString(),
                    angle: angle,
                    color: color,
                  ));
              Navigator.of(context).pop();
            },
            child: const Text("Accept"),
          ),
        ],
      );
    },
  );
}
