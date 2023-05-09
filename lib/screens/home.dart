import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/screens/note_detail.dart';
import 'package:notes/utils/functions/date_format.dart';
import 'package:notes/utils/services/notes_list.dart';
import 'package:notes/utils/services/result_list.dart';
import '../models/note.dart';
import '../utils/services/date_format.dart';
import '../utils/ui/add_note_dialog.dart';
import '../utils/ui/settings_dialog.dart';

class Home extends HookWidget {
  const Home({super.key});

  void clearResults(WidgetRef ref, TextEditingController controller, ValueNotifier<bool> isVisibleNotifier) {
    ref.read(resultStateNotifierProvider.notifier).deleteList();
    controller.clear();
    isVisibleNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    final isVisibleNotifier = useState(false);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final List<Note> resultList = ref.watch(resultStateNotifierProvider);
        final List<Note> notesList = ref.watch(noteStateNotifierProvider);
        final int switchValue = ref.watch(dateStateNotifierProvider);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  settingsDialog(context);
                },
                icon: const Icon(Icons.settings),
              )
            ],
            centerTitle: true,
            title: const Text('Notes'),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                clearResults(ref, searchTextController, isVisibleNotifier);
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextField(
                                controller: searchTextController,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    clearResults(ref, searchTextController, isVisibleNotifier);
                                  } else {
                                    isVisibleNotifier.value = true;
                                    ref.read(resultStateNotifierProvider.notifier).search(notesList, value);
                                  }
                                },
                                decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(minWidth: 50),
                                    hintText: "Search Note...",
                                    iconColor: Colors.white,
                                    icon: const Icon(Icons.search),
                                    border: InputBorder.none,
                                    suffixIcon: isVisibleNotifier.value
                                        ? IconButton(
                                            icon: const Icon(Icons.cancel),
                                            onPressed: (() {
                                              clearResults(ref, searchTextController, isVisibleNotifier);
                                            }),
                                          )
                                        : const SizedBox(
                                            width: 0,
                                          ),
                                    suffixIconColor: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      isVisibleNotifier.value
                          ? TextButton(
                              child: const Text(
                                "Cancel",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                clearResults(ref, searchTextController, isVisibleNotifier);
                              },
                            )
                          : const SizedBox(
                              width: 0,
                            ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteDetails(
                                note: notesList[index],
                              ),
                            ),
                          );
                          clearResults(ref, searchTextController, isVisibleNotifier);
                        },
                        child: Card(
                          color: Color(resultList[index].color),
                          child: ListTile(
                            title: Text(resultList[index].title),
                            subtitle: Text(resultList[index].body),
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      shrinkWrap: true,
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        var note = notesList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteDetails(
                                  note: note,
                                ),
                              ),
                            );

                            if (isVisibleNotifier.value) {
                              clearResults(ref, searchTextController, isVisibleNotifier);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform.rotate(
                              angle: note.angle * math.pi / 180,
                              child: Card(
                                color: Color(note.color),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(5),
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          ref.read(noteStateNotifierProvider.notifier).deleteNote(note.id);
                                        },
                                        icon: const Icon(Icons.delete_forever),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(formatDate(note.date, switchValue)),
                                              Text(
                                                note.title.length > 10 ? '${note.title.substring(0, 9)}...' : note.title,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(note.body),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addNoteDialog(context, ref);
            },
            child: const Icon(Icons.note_add),
          ),
        );
      },
    );
  }
}
