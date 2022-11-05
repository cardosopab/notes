import 'package:flutter/material.dart';

import '../models/nota.dart';

class NotaPage extends StatelessWidget {
  final Nota nota;
  const NotaPage({required this.nota, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(nota.titulo),
      ),
      body: Column(
        children: [
          Text(nota.cuerpo),
        ],
      ),
    );
  }
}
