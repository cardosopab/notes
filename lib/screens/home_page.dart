import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notas/screens/nota_page.dart';
import 'package:notas/widgets/setttings_popup_widget.dart';

import '../services/preferences_list.dart';
import '../widgets/nota_popup_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    PreferencesList().initPref().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                settingsPopupWidget(context).then((value) => setState(() {}));
              },
              icon: const Icon(Icons.settings))
          // DropdownButton(
          //     value: valorEscogido,
          //     items: <String>[
          //       'Titulo',
          //       'Fecha',
          //     ].map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem(value: value, child: Text(value));
          //     }).toList(),
          //     onChanged: (String? value) {
          //       valorEscogido = value!;
          //       setState(() {});
          //     }),
        ],
        centerTitle: true,
        title: const Text('Notas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: notas.length,
              itemBuilder: (context, index) {
                var nota = notas[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotaPage(nota: nota)));
                  },
                  child: Column(
                    children: [
                      Text(
                        nota.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(DateFormat.yMd().format(nota.fecha)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notaPopupWidget(context).then((_) {
            // notas.clear();
          }).then((_) => setState(() {}));
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
