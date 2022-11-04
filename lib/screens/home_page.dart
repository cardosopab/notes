import 'package:flutter/material.dart';

import '../services/preferences_list.dart';
import '../widgets/nota_PopupWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    PreferencesList().readNotaPref().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                return Column(
                  children: [
                    Text(
                      nota.titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(nota.fecha),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NotaPopupWidget(context).then((_) => PreferencesList().writeNotaPref()).then((_) => setState(() {}));
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
