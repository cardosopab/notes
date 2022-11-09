import '../models/nota.dart';

class Reordenar {
  Future<void> porTitulo(List<Nota> notas) async {
    notas.sort((a, b) => a.titulo.compareTo(b.titulo));
  }

  void porFecha(List<Nota> notas) {
    notas.sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  void porCuerpo(List<Nota> notas) {
    notas.sort((a, b) => a.cuerpo.compareTo(b.cuerpo));
  }
}
