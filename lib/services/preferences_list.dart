import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

List<Todo> todoList = <Todo>[];

class PreferencesList {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> writeTodoPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String> spList = todoList.map((todo) => convert.jsonEncode(todo.toJson())).toList();
    prefs.setStringList('todo', spList);
  }

  Future<void> readTodoPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String>? spList = prefs.getStringList('todo');
    todoList = spList?.map((todo) => Todo.fromJson(convert.jsonDecode(todo))).toList() ?? [];
  }
}
