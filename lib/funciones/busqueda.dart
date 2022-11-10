import '../modelos/nota.dart';

class Busqueda {
  List<Nota> busqueda(List<Nota> listaDeNotas, valor) {
    List<Nota> listaDeTitulos = [];
    List<Nota> listaDeCuerpo = [];

    listaDeTitulos = Busqueda().buscaTitulo(listaDeNotas, valor);
    listaDeCuerpo = Busqueda().buscaCuerpo(listaDeNotas, valor);
    // eliminado duplicados
    return (listaDeTitulos + listaDeCuerpo).toSet().toList();
  }

  List<Nota> buscaTitulo(List<Nota> listaDeNotas, valor) {
    return listaDeNotas.where((element) {
      return element.titulo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }

  List<Nota> buscaCuerpo(List<Nota> listaDeNotas, valor) {
    return listaDeNotas.where((element) {
      return element.cuerpo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }
}
