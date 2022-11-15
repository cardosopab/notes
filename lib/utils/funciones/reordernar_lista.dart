import '../../modelos/nota.dart';
class Reordenar {
  /// Reordenando listaDeNotas por titulo
  Future<void> porTitulo(List<Nota> listaDeNotas) async {
    listaDeNotas.sort((a, b) => a.titulo.compareTo(b.titulo));
  }

  /// Reordenando listaDeNotas por fecha
  void porFecha(List<Nota> listaDeNotas) {
    listaDeNotas.sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  /// Reordenando listaDeNotas por cuerpo
  void porCuerpo(List<Nota> listaDeNotas) {
    listaDeNotas.sort((a, b) => a.cuerpo.compareTo(b.cuerpo));
  }
}
