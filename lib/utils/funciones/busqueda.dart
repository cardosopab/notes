import '../../modelos/nota.dart';

class Busqueda {
  /// Buscando por titulo, y por cuerpo
  List<Nota> busqueda(List<Nota> listaDeNotas, valor) {
    List<Nota> listaDeTitulos = [];
    List<Nota> listaDeCuerpo = [];

    listaDeTitulos = Busqueda().buscaTitulo(listaDeNotas, valor);
    listaDeCuerpo = Busqueda().buscaCuerpo(listaDeNotas, valor);
    /// Eliminado duplicados
    return (listaDeTitulos + listaDeCuerpo).toSet().toList();
  }
  /// Buscando por titulo
  List<Nota> buscaTitulo(List<Nota> listaDeNotas, valor) {
    return listaDeNotas.where((element) {
      return element.titulo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }

  /// Buscando por cuerpo
  List<Nota> buscaCuerpo(List<Nota> listaDeNotas, valor) {
    return listaDeNotas.where((element) {
      return element.cuerpo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }
}
