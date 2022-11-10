import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modelos/nota.dart';

class NotasNotifier extends StateNotifier<List<Nota>> {
  NotasNotifier() : super([]);

  void agregaNota(Nota nota) {
    state = [...state, nota];
  }

  void eliminaNota(String notaId) {
    state = [
      for (final nota in state)
        if (nota.id != notaId) nota,
    ];
  }

  void actualizarNota(Nota newNota, String notaId) {
    state = [
      for (final nota in state)
        if (nota.id != notaId) nota,
    ];
    state = [...state, newNota];
  }
}

final notasStateNotifierProvider = StateNotifierProvider<NotasNotifier, List<Nota>>((ref) {
  return NotasNotifier();
});
