import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/nota.dart';

class PreferencesList {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> deleteNotaPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String> spList = [];
    prefs.setStringList('Notas', spList);
  }

  Future<void> writeNotaPref(List<Nota> notas) async {
    final SharedPreferences prefs = await _prefs;
    List<String> spList = notas.map((nota) => convert.jsonEncode(nota.toJson())).toList();
    prefs.setStringList('Notas', spList);
  }

  Future<List<Nota>?> readNotaPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String>? spList = prefs.getStringList('Notas');
    List<Nota> notasList = [];
    notasList = spList?.map((nota) => Nota.fromJson(convert.jsonDecode(nota))).toList() ?? [];
    return notasList;
  }
}
