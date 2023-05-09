import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/note.dart';

class ResultNotfier extends StateNotifier<List<Note>> {
  ResultNotfier() : super([]);
  void search(List<Note> notesList, value) {
    List<Note> titleList = ResultNotfier()._searchTitle(notesList, value);
    List<Note> bodyList = ResultNotfier()._searchBody(notesList, value);

    state = (titleList + bodyList).toSet().toList();
  }

  List<Note> _searchTitle(List<Note> notesList, value) {
    return notesList.where((element) {
      return element.title.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }

  List<Note> _searchBody(List<Note> notesList, value) {
    return notesList.where((element) {
      return element.body.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }

  void deleteList() {
    state = [];
  }
}

final resultStateNotifierProvider = StateNotifierProvider<ResultNotfier, List<Note>>((ref) {
  return ResultNotfier();
});
