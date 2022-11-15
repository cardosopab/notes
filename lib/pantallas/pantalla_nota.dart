import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/utils/servicios/lista_de_preferencias.dart';
import 'package:notas/utils/servicios/lista_de_notas.dart';
import '../modelos/nota.dart';

class PantallaNota extends ConsumerWidget {
  final Nota nota;
  PantallaNota({required this.nota, super.key});
  final controladorDeTextoDeCuerpo = TextEditingController();
  final controladorDeTextoDeTitulo = TextEditingController();
  final enfoqueDeCuerpo = FocusNode();
  final enfoqueDeTitulo = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controladorDeTextoDeCuerpo.text = nota.cuerpo;
    controladorDeTextoDeTitulo.text = nota.titulo;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            padding: const EdgeInsets.all(5),
            constraints: const BoxConstraints(),

            /// Si hubo cambios, bora la nota, y crea una nota nueva con cuerpo y titulo nuevo
            onPressed: () {
              if (nota.titulo != controladorDeTextoDeTitulo.text || nota.cuerpo != controladorDeTextoDeCuerpo.text) {
                ref.read(notasStateNotifierProvider.notifier).actualizaNota(
                    Nota(
                      titulo: controladorDeTextoDeTitulo.text,
                      cuerpo: controladorDeTextoDeCuerpo.text,
                      fecha: nota.fecha,
                      id: nota.id,
                      angulo: nota.angulo,
                      color: nota.color,
                    ),
                    nota.id);

                /// Guarda nueva listaDeNotas con shared_preferences
                final listaDeNotas = ref.watch(notasStateNotifierProvider);
                ListaDePreferencias().escribirNotaPref(listaDeNotas);
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
        centerTitle: true,
        title: EditableText(
          textAlign: TextAlign.center,
          backgroundCursorColor: Colors.black,
          controller: controladorDeTextoDeTitulo,
          cursorColor: Colors.white,
          focusNode: enfoqueDeTitulo,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                color: Color(nota.color),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: EditableText(
                    maxLines: null,
                    backgroundCursorColor: Colors.black,
                    controller: controladorDeTextoDeCuerpo,
                    cursorColor: Colors.white,
                    focusNode: enfoqueDeCuerpo,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
