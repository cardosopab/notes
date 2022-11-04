import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/nota.dart';
import '../services/preferences_list.dart';

Future<dynamic> NotaPopupWidget(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      final tituloController = TextEditingController();
      final cuerpoController = TextEditingController();
      final fechaController = TextEditingController();
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
                  hintText: 'Que quieres hacer?',
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
              fechaController.text = DateFormat.yMd().format(DateTime.now());
              notas.add(Nota(
                titulo: tituloController.text, //
                cuerpo: cuerpoController.text,
                fecha: fechaController.text,
              ));
              Navigator.of(context).pop();
            },
            child: const Text("Acceptar"),
          ),
        ],
      );
    },
  );
}
