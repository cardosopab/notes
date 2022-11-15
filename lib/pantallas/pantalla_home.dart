import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notas/utils/funciones/busqueda.dart';
import 'package:notas/pantallas/pantalla_nota.dart';
import 'package:notas/utils/servicios/lista_de_preferencias.dart';
import 'package:notas/utils/servicios/lista_de_notas.dart';
import '../modelos/nota.dart';
import '../utils/ui/agrega_nota_dialogo.dart';
import '../utils/ui/ajustes_dialogo.dart';

class PantallaHome extends ConsumerStatefulWidget {
  const PantallaHome({super.key});

  @override
  PantallaHomeState createState() => PantallaHomeState();
}

class PantallaHomeState extends ConsumerState<PantallaHome> {
  final TextEditingController controladorDeTextoDeBusqueda = TextEditingController();
  final nodoDeEnfoque = FocusNode();
  List<Nota> listaDeResulatados = [];
  bool esVisible = false;

  @override
  void initState() {
    super.initState();

    /// Leer lista de preferencias, cual son notas guardadas en el dispositivo, con shared_preferences
    ListaDePreferencias().leeListaDePref().then((listaDePreferencias) {
      /// Si no esta vacia, agrega la listaDePreferencias con Riverpod
      if (listaDePreferencias != null) {
        for (Nota nota in listaDePreferencias) {
          ref.read(proveedorNotificadorDeEstadoDeNotas.notifier).agregaNota(nota);
        }
      }
    });
  }

  @override
  void dispose() {
    nodoDeEnfoque.dispose();
    super.dispose();
  }

  void borrarBusqueda() {
    nodoDeEnfoque.unfocus();
    controladorDeTextoDeBusqueda.clear();
    listaDeResulatados.clear();
    esVisible = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /// Crear la listaDeNotas con Riverpod
    List<Nota> listaDeNotas = ref.watch(proveedorNotificadorDeEstadoDeNotas);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ajustesDialogo(context, listaDeNotas).then((_) => setState(() {}));
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
            esVisible = false;
            borrarBusqueda();
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
                            controller: controladorDeTextoDeBusqueda,
                            onChanged: (valor) {
                              if (valor.isEmpty) {
                                esVisible = false;
                                listaDeResulatados.clear();
                              } else {
                                esVisible = true;
                                listaDeResulatados = Busqueda().busqueda(listaDeNotas, valor);
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

                                /// Si esVisible es sierto, muestra los botones para borrar la busqueda
                                suffixIcon: esVisible
                                    ? IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: (() {
                                          esVisible = false;
                                          borrarBusqueda();
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

                  /// Si esVisible es sierto, muestra los botones para borrar la busqueda
                  esVisible
                      ? TextButton(
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            esVisible = false;
                            borrarBusqueda();
                          },
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listaDeResulatados.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      /// Variables para el indice de listaDeNotas
                      String id = listaDeResulatados[index].id;
                      int idx = listaDeNotas.indexWhere((element) => element.id == id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaNota(
                            nota: listaDeNotas[idx],
                          ),
                        ),
                      );
                      esVisible = false;
                      borrarBusqueda();
                    },
                    child: Card(
                      color: Color(listaDeResulatados[index].color),
                      child: ListTile(
                        title: Text(listaDeResulatados[index].titulo),
                        subtitle: Text(listaDeResulatados[index].cuerpo),
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  shrinkWrap: true,
                  itemCount: listaDeNotas.length,
                  itemBuilder: (context, index) {
                    var nota = listaDeNotas[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PantallaNota(
                              nota: nota,
                            ),
                          ),
                        );

                        /// Si esVisible es sierto, borra la lista de resultos de la busqueda
                        if (esVisible == true) {
                          esVisible == false;
                          borrarBusqueda();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Transform.rotate(
                          angle: nota.angulo * math.pi / 180,
                          child: Card(
                            color: Color(nota.color),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(5),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      /// Borra la nota con Riverpod
                                      ref.read(proveedorNotificadorDeEstadoDeNotas.notifier).eliminaNota(nota.id);

                                      /// Lista de notas nueva, sin la nota borrada
                                      List<Nota> listaDeNotas = ref.watch(proveedorNotificadorDeEstadoDeNotas);

                                      /// Guarda la lista nueva con shared_preferences
                                      ListaDePreferencias().guardarNota(listaDeNotas);
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
                                          /// Convierte fecha a formato de dia mes ano
                                          Text(DateFormat('dd/MM/yy').format(nota.fecha)),
                                          Text(
                                            /// Si titulo.length es mas de 10, reemplaza el restante con '...'
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
          agregaNotaDialogo(context, ref);
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
