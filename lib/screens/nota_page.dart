import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/services/preferences_list.dart';
import 'package:notas/services/providers.dart';

import '../models/nota.dart';

class NotaPage extends ConsumerWidget {
  final Nota nota;
  final int index;
  NotaPage({required this.nota, required this.index, super.key});
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
        ref.read(notasStateNotifierProvider.notifier).updateNota(
            Nota(
              titulo: tituloController.text,
              cuerpo: cuerpoController.text,
              fecha: nota.fecha,
              id: nota.id,
              angle: nota.angle,
              color: nota.color,
            ),
            nota.id);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              padding: const EdgeInsets.all(5),
              constraints: const BoxConstraints(),
              onPressed: () {
                ref.read(notasStateNotifierProvider.notifier).removeNota(nota.id);
                List<Nota> notas = ref.watch(notasStateNotifierProvider);
                PreferencesList().writeNotaPref(notas);
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
                    padding: const EdgeInsets.all(8.0),
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
