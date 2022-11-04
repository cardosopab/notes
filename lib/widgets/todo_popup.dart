import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../services/preferences_list.dart';

Future<dynamic> todoPopupWidget(BuildContext context) {
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
                controller: cuerpoController,
                decoration: const InputDecoration(
                  hintText: 'Que quieres hacer?',
                ),
              ),
              TextField(
                controller: fechaController,
                decoration: const InputDecoration(
                  hintText: 'Para cuando?',
                ),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 30),
                    ),
                  );
                  fechaController.text = DateFormat.yMd().format(date!);
                },
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
              todoList.add(
                Todo(
                    titulo: tituloController.text, //
                    cuerpo: cuerpoController.text,
                    fecha: fechaController.text),
              );
              Navigator.of(context).pop();
            },
            child: const Text("Acceptar"),
          ),
        ],
      );
    },
  );
}
