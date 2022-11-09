import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notas/functions/busqueda.dart';
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

  final gridViewController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void borrarBusqueda() {
    searchController.clear();
  }

  List<Nota> busquedaResultados = [];

  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    List<Nota> notas = ref.watch(notasStateNotifierProvider);
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
        child: GestureDetector(
          onTap: () {
            focusNode.unfocus();
            borrarBusqueda();
            busquedaResultados.clear();
            setState(() {});
          },
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextField(
                            controller: searchController,
                            onChanged: (valor) {
                              if (valor.isEmpty) {
                                busquedaResultados.clear();
                              } else {
                                List<Nota> listaDeTitulos = [];
                                List<Nota> listaDeCuerpo = [];

                                listaDeTitulos = Busqueda().buscaTitulo(ref, valor);
                                listaDeCuerpo = Busqueda().buscaCuerpo(ref, valor);
                                busquedaResultados = listaDeTitulos + listaDeCuerpo;
                                busquedaResultados = busquedaResultados.toSet().toList();
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                prefixIconConstraints: const BoxConstraints(minWidth: 50),
                                hintText: "Busca Nota...",
                                iconColor: Colors.white,
                                icon: const Icon(Icons.search),
                                border: InputBorder.none,
                                suffixIcon: isVisible
                                    ? IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: (() {
                                          // deleteSearch();
                                        }),
                                      )
                                    : const SizedBox(
                                        width: 0,
                                      ),
                                suffixIconColor: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  isVisible
                      ? TextButton(
                          onPressed: (() {
                            // deleteSearch();
                          }),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: busquedaResultados.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      String id = busquedaResultados[index].id;
                      int idx = notas.indexWhere((element) => element.id == id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotaPage(
                            nota: notas[idx],
                            index: idx,
                          ),
                        ),
                      );
                      borrarBusqueda();
                      busquedaResultados.clear();
                      setState(() {});
                    },
                    child: Card(
                      color: Color(busquedaResultados[index].color),
                      child: ListTile(
                        title: Text(busquedaResultados[index].titulo),
                        subtitle: Text(busquedaResultados[index].cuerpo),
                      ),
                    ),
                  );
                },
              ),
              Expanded(
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
            ],
          ),
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
