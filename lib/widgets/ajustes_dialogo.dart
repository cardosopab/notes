import 'package:flutter/material.dart';
import '../funciones/reordernar_lista.dart';
import '../modelos/nota.dart';

String valorEscogido = "Fecha";
Future<dynamic> ajustesDialogoWidget(BuildContext context, List<Nota> listaDeNotas) async {
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
              switch (valorEscogido) {
                case 'Titulo':
                  {
                    Reordenar().porTitulo(listaDeNotas);
                  }
                  break;
                case 'Fecha':
                  {
                    Reordenar().porFecha(listaDeNotas);
                  }
                  break;
                case 'Cuerpo':
                  {
                    Reordenar().porCuerpo(listaDeNotas);
                  }
                  break;
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
