import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notas/screens/nota_page.dart';
import 'package:notas/services/preferences_list.dart';
import 'package:notas/services/providers.dart';
import '../models/nota.dart';
import '../widgets/nota_popup_widget.dart';
import 'dart:math' as math;

import '../widgets/setttings_popup_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    PreferencesList().readNotaPref().then((value) {
      if (value != null) {
        for (Nota n in value) {
          ref.read(notasStateNotifierProvider.notifier).addNota(n);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notas = ref.watch(notasStateNotifierProvider);
    final gridViewController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              settingsPopupWidget(context, notas).then((value) => setState(() {}));
            },
            icon: const Icon(Icons.settings),
          )
        ],
        centerTitle: true,
        title: const Text('Notas'),
      ),
      body: SafeArea(
        child: GridView.builder(
          dragStartBehavior: DragStartBehavior.down,
          controller: gridViewController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          shrinkWrap: true,
          itemCount: notas.length,
          itemBuilder: (context, index) {
            var nota = notas[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotaPage(
                      nota: nota,
                      index: index,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  angle: nota.angle * math.pi / 180,
                  child: Card(
                    color: Color(nota.color),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            padding: const EdgeInsets.all(5),
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              ref.read(notasStateNotifierProvider.notifier).removeNota(nota.id);
                              List<Nota> notas = ref.watch(notasStateNotifierProvider);
                              PreferencesList().writeNotaPref(notas);
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(DateFormat.yMd().format(nota.fecha)),
                                  Text(
                                    nota.titulo.length > 10 ? '${nota.titulo.substring(0, 9)}...' : nota.titulo,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(nota.cuerpo),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notaPopupWidget(context, ref).then((value) => setState(() {})).then((_) {});
          // PreferencesList().deleteNotaPref();
          // gridViewController.animateTo(gridViewController.position.maxScrollExtent,
          //       duration: const Duration(milliseconds: 600), curve: Curves.fastOutSlowIn);
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
