// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nota _$NotaFromJson(Map<String, dynamic> json) => Nota(
      titulo: json['titulo'] as String,
      cuerpo: json['cuerpo'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      id: json['id'] as String,
      color: json['color'] as int,
      angulo: json['angulo'] as int,
    );

Map<String, dynamic> _$NotaToJson(Nota instance) => <String, dynamic>{
      'titulo': instance.titulo,
      'cuerpo': instance.cuerpo,
      'id': instance.id,
      'angulo': instance.angulo,
      'color': instance.color,
      'fecha': instance.fecha.toIso8601String(),
    };
