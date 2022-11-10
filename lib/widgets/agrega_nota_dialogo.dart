import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/servicios/lista_de_preferencias.dart';
import 'package:notas/servicios/proveedor.dart';
import '../modelos/nota.dart';
import '../funciones/objeto_random.dart';

Future<dynamic> agregaNotaDialogoWidget(BuildContext context, WidgetRef ref) {
  return showDialog(
    context: context,
    builder: (context) {
      final controladorDeTextoDeTitulo = TextEditingController();
      final controladorDeTextoDeCuerpo = TextEditingController();
      return AlertDialog(
        title: const Text("Agrega una nota"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controladorDeTextoDeTitulo,
                decoration: const InputDecoration(
                  hintText: 'Titulo',
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 10,
                controller: controladorDeTextoDeCuerpo,
                decoration: const InputDecoration(
                  hintText: 'Cuerpo',
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
              //coleccionando neuvos variables
              DateTime fecha = DateTime.now();
              int angulo = ObjetoRandom().randomNumberoEntre(350, 355);
              int color = ObjetoRandom().colorRandom();
              //agregando la nota con Riverpod
              ref.read(notasStateNotifierProvider.notifier).agregaNota(Nota(
                    titulo: controladorDeTextoDeTitulo.text,
                    cuerpo: controladorDeTextoDeCuerpo.text,
                    fecha: fecha,
                    id: fecha.toString(),
                    angulo: angulo,
                    color: color,
                  ));
              //leyendo nueva lista de notas
              List<Nota> listaDeNotas = ref.watch(notasStateNotifierProvider);
              //guardando nueva lista con shared_preferences
              ListaDePreferencias().escribirNotaPref(listaDeNotas);
              Navigator.of(context).pop();
            },
            child: const Text("Acceptar"),
          ),
        ],
      );
    },
  );
}
