import 'package:notas/services/preferences_list.dart';

class Reordenar {
  Future<void> porTitulo() async {
    notas.sort((a, b) => a.titulo.compareTo(b.titulo));
  }

  void porFecha() {
    notas.sort((a, b) => a.fecha.compareTo(b.fecha));
  }
}
