import 'package:flutter/material.dart';
import 'package:notas/functions/reordernar_lista.dart';
import 'package:notas/services/preferences_list.dart';

Future<dynamic> settingsPopupWidget(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Escoge el orden"),
        content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                DropdownButton(
                    value: valorEscogido,
                    items: <String>[
                      'Titulo',
                      'Fecha',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? value) {
                      valorEscogido = value!;
                      if (valorEscogido == 'Titulo') {
                        Reordenar().porTitulo();
                        setState(() {});
                      }
                      if (valorEscogido == 'Fecha') {
                        Reordenar().porFecha();
                      }
                      setState(() {});
                    }),
              ],
            ),
          );
        }),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              PreferencesList().writeSortPref(valorEscogido);
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
