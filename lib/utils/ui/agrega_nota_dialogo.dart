import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas/utils/servicios/lista_de_preferencias.dart';
import 'package:notas/utils/servicios/lista_de_notas.dart';
import '../../modelos/nota.dart';
import '../funciones/aleatorio.dart';

Future<dynamic> agregaNotaDialogo(BuildContext context, WidgetRef ref) {
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
              /// Coleccionando neuvos variables
              DateTime fecha = DateTime.now();
              int angulo = Aleatorio().anguloAleatorioDentroDe(350, 355);
              int color = Aleatorio().colorAleatorio();

              /// Agregando la nota con Riverpod
              ref.read(proveedorNotificadorDeEstadoDeNotas.notifier).agregaNota(Nota(
                    titulo: controladorDeTextoDeTitulo.text,
                    cuerpo: controladorDeTextoDeCuerpo.text,
                    fecha: fecha,
                    id: fecha.toString(),
                    angulo: angulo,
                    color: color,
                  ));

              /// Leyendo nueva lista de notas
              List<Nota> listaDeNotas = ref.watch(proveedorNotificadorDeEstadoDeNotas);

              /// Guardando nueva lista con shared_preferences
              ListaDePreferencias().guardarNota(listaDeNotas);
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
