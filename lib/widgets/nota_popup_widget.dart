import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/services/preferences_list.dart';
import 'package:notas/services/providers.dart';
import '../models/nota.dart';
import '../functions/objeto_random.dart';

Future<dynamic> notaPopupWidget(BuildContext context, WidgetRef ref) {
  return showDialog(
    context: context,
    builder: (context) {
      final tituloController = TextEditingController();
      final cuerpoController = TextEditingController();
      return AlertDialog(
        title: const Text("Agrega una nota"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Titulo',
                ),
              ),
              TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 10,
                  controller: cuerpoController,
                  decoration: const InputDecoration(
                    hintText: 'Cuerpo',
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              DateTime date = DateTime.now();
              int angle = ObjetoRandom().randomBetween(345, 360);
              int color = ObjetoRandom().colorRandom();
              ref.read(notasStateNotifierProvider.notifier).addNota(Nota(
                    titulo: tituloController.text,
                    cuerpo: cuerpoController.text,
                    fecha: date,
                    id: date.toString(),
                    angle: angle,
                    color: color,
                  ));
              List<Nota> notas = ref.watch(notasStateNotifierProvider);
              PreferencesList().writeNotaPref(notas);
              Navigator.of(context).pop();
            },
            child: const Text("Acceptar"),
          ),
        ],
      );
    },
  );
}
