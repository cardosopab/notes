import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/nota.dart';

class NotasNotifier extends StateNotifier<List<Nota>> {
  NotasNotifier() : super([]);

  void addNota(Nota nota) {
    state = [...state, nota];
  }

  void removeNota(String notaId) {
    state = [
      for (final nota in state)
        if (nota.id != notaId) nota,
    ];
  }

  void updateNota(Nota newNota, String notaId) {
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
