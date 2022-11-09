import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/services/providers.dart';

import '../models/nota.dart';

class Busqueda {
  List<Nota> buscaTitulo(WidgetRef ref, valor) {
    List<Nota> notas = ref.watch(notasStateNotifierProvider);
    return notas.where((element) {
      return element.titulo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }
  List<Nota> buscaCuerpo(WidgetRef ref, valor) {
    List<Nota> notas = ref.watch(notasStateNotifierProvider);
    return notas.where((element) {
      return element.cuerpo.toLowerCase().contains(valor.toLowerCase());
    }).toList();
  }
}
