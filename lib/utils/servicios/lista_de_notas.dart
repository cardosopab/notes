import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modelos/nota.dart';

class NotificadorDeNotas extends StateNotifier<List<Nota>> {
  NotificadorDeNotas() : super([]);

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

final proveedorNotificadorDeEstadoDeNotas = StateNotifierProvider<NotificadorDeNotas, List<Nota>>((ref) {
  return NotificadorDeNotas();
});
