import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modelos/nota.dart';

class NotasNotifier extends StateNotifier<List<Nota>> {
  NotasNotifier() : super([]);

  void agregaNota(Nota nota) {
    /// Agrega nota al estado
    state = [...state, nota];
  }

  void eliminaNota(String notaId) {
    /// Borra nota del estado
    state = [
      for (final nota in state)
        if (nota.id != notaId) nota,
    ];
  }

  void actualizaNota(Nota notaNueva, String notaId) {
    /// Borra nota del estado
    state = [
      for (final nota in state)
        if (nota.id != notaId) nota,
    ];

    /// Agrega nota nueva al estado
    state = [...state, notaNueva];
  }
}

final notasStateNotifierProvider = StateNotifierProvider<NotasNotifier, List<Nota>>((ref) {
  return NotasNotifier();
});
