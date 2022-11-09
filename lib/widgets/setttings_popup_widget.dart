import 'package:flutter/material.dart';

import '../functions/reordernar_lista.dart';
import '../models/nota.dart';

String valorEscogido = "Fecha";
Future<dynamic> settingsPopupWidget(BuildContext context, List<Nota> notas) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Escoge el orden"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButton(
                    dropdownColor: const Color(0xff76504E),
                    value: valorEscogido,
                    items: <String>[
                      'Fecha',
                      'Titulo',
                      'Cuerpo',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      valorEscogido = value!;
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
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
              if (valorEscogido == 'Titulo') {
                Reordenar().porTitulo(notas);
              }
              if (valorEscogido == 'Fecha') {
                Reordenar().porFecha(notas);
              }
              if (valorEscogido == 'Cuerpo') {
                Reordenar().porCuerpo(notas);
              }
              Navigator.of(context).pop();
            },
            child: const Text("Acceptar"),
          ),
        ],
      );
    },
  );
}
