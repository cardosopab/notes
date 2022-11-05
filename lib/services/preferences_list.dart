import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import '../models/nota.dart';

List<Nota> notas = <Nota>[];

late String valorEscogido;

class PreferencesList {
  Future<void> initPref() async {
    valorEscogido = await PreferencesList().readSortPref();
    await PreferencesList().readNotaPref();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> writeNotaPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String> spList = notas.map((nota) => convert.jsonEncode(nota.toJson())).toList();
    prefs.setStringList('Notas', spList);
  }

  Future<void> readNotaPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String>? spList = prefs.getStringList('Notas');
    notas = spList?.map((nota) => Nota.fromJson(convert.jsonDecode(nota))).toList() ?? [];
  }

  Future<void> writeSortPref(sort) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('Sort', sort);
  }

  Future<String> readSortPref() async {
    final SharedPreferences prefs = await _prefs;
    final sortPref = prefs.getString('Sort');
    return sortPref ?? 'Fecha';
  }
}
