import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/servicios/proveedor.dart';

import '../modelos/nota.dart';

class Busqueda {
  List<Nota> busqueda(WidgetRef ref, valor, List<Nota> lista) {
    List<Nota> listaDeTitulos = [];
    List<Nota> listaDeCuerpo = [];

    listaDeTitulos = Busqueda().buscaTitulo(ref, valor);
    listaDeCuerpo = Busqueda().buscaCuerpo(ref, valor);
    lista = listaDeTitulos + listaDeCuerpo;
    lista = lista.toSet().toList();
    print(valor);
    print(lista.length);
    return lista;
  }

  List<Nota> buscaTitulo(WidgetRef ref, valor) {
    List<Nota> listaDeNotas = ref.watch(notasStateNotifierProvider);
    return listaDeNotas.where((element) {
      return element.titulo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }

  List<Nota> buscaCuerpo(WidgetRef ref, valor) {
    List<Nota> listaDeNotas = ref.watch(notasStateNotifierProvider);
    return listaDeNotas.where((element) {
      return element.cuerpo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }
}
