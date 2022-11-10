import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/material.dart';

part 'nota.g.dart';

@JsonSerializable()
@immutable
class Nota {
  final String titulo, cuerpo, id;
  final int angulo, color;
  final DateTime fecha;
  const Nota({
    required this.titulo,
    required this.cuerpo,
    required this.fecha,
    required this.id,
    required this.color,
    required this.angulo,
  });

  factory Nota.fromJson(Map<String, dynamic> json) => _$NotaFromJson(json);
  Map<String, dynamic> toJson() => _$NotaToJson(this);
  Nota copyWith({
    String? titulo,
    String? cuerpo,
    String? id,
    int? color,
    int? angulo,
    DateTime? fecha,
  }) {
    return Nota(
      titulo: titulo ?? this.titulo,
      cuerpo: cuerpo ?? this.cuerpo,
      fecha: fecha ?? this.fecha,
      id: id ?? this.id,
      color: color ?? this.color,
      angulo: angulo ?? this.angulo,
    );
  }
}
