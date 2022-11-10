import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import '../modelos/nota.dart';

class ListaDePreferencias {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> escribirNotaPref(List<Nota> listaDeNotas) async {
    final SharedPreferences prefs = await _prefs;
    List<String> spList = listaDeNotas.map((nota) => convert.jsonEncode(nota.toJson())).toList();
    prefs.setStringList('Notas', spList);
  }

  Future<List<Nota>?> leerNotaPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String>? spList = prefs.getStringList('Notas');
    List<Nota> notasList = [];
    notasList = spList?.map((nota) => Nota.fromJson(convert.jsonDecode(nota))).toList() ?? [];
    return notasList;
  }

  Future<void> borrarNotaPref() async {
    final SharedPreferences prefs = await _prefs;
    List<String> spList = [];
    prefs.setStringList('Notas', spList);
  }
}
