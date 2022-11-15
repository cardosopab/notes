import '../../modelos/nota.dart';

class Reordenar {
  Future<void> porTitulo(List<Nota> listaDeNotas) async {
    listaDeNotas.sort((a, b) => a.titulo.compareTo(b.titulo));
  }

  void porFecha(List<Nota> listaDeNotas) {
    listaDeNotas.sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  void porCuerpo(List<Nota> listaDeNotas) {
    listaDeNotas.sort((a, b) => a.cuerpo.compareTo(b.cuerpo));
  }
}
