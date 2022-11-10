import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/servicios/lista_de_preferencias.dart';
import 'package:notas/servicios/proveedor.dart';

import '../modelos/nota.dart';

class PantallaNota extends ConsumerWidget {
  final Nota nota;
  final int index;
  PantallaNota({required this.nota, required this.index, super.key});
  final cuerpoController = TextEditingController();
  final tituloController = TextEditingController();
  final cuerpoFocus = FocusNode();
  final tituloFocus = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    cuerpoController.text = nota.cuerpo;
    tituloController.text = nota.titulo;
    return WillPopScope(
      onWillPop: () async {
        if (nota.titulo != tituloController.text || nota.cuerpo != cuerpoController.text) {
          ref.read(notasStateNotifierProvider.notifier).actualizarNota(
              Nota(
                titulo: tituloController.text,
                cuerpo: cuerpoController.text,
                fecha: nota.fecha,
                id: nota.id,
                angulo: nota.angulo,
                color: nota.color,
              ),
              nota.id);
          final listaDeNotas = ref.watch(notasStateNotifierProvider);
          ListaDePreferencias().escribirNotaPref(listaDeNotas);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              padding: const EdgeInsets.all(5),
              constraints: const BoxConstraints(),
              onPressed: () {
                ref.read(notasStateNotifierProvider.notifier).eliminaNota(nota.id);
                List<Nota> listaDeNotas = ref.watch(notasStateNotifierProvider);
                ListaDePreferencias().escribirNotaPref(listaDeNotas);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete_forever),
            ),
          ],
          centerTitle: true,
          title: EditableText(
            textAlign: TextAlign.center,
            backgroundCursorColor: Colors.black,
            controller: tituloController,
            cursorColor: Colors.white,
            focusNode: tituloFocus,
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
                      controller: cuerpoController,
                      cursorColor: Colors.white,
                      focusNode: cuerpoFocus,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
