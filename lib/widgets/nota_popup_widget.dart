import 'package:flutter/material.dart';
import '../models/nota.dart';
import '../services/preferences_list.dart';

Future<dynamic> notaPopupWidget(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      final tituloController = TextEditingController();
      final cuerpoController = TextEditingController();
      return AlertDialog(
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
                ),
              ),
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
              notas.add(Nota(
                titulo: tituloController.text, //
                cuerpo: cuerpoController.text,
                fecha: DateTime.now(),
              ));
              PreferencesList().writeNotaPref();
              Navigator.of(context).pop();
            },
            child: const Text("Acceptar"),
          ),
        ],
      );
    },
  );
}
