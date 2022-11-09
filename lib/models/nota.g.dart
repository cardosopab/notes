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
      angle: json['angle'] as int,
    );

Map<String, dynamic> _$NotaToJson(Nota instance) => <String, dynamic>{
      'titulo': instance.titulo,
      'cuerpo': instance.cuerpo,
      'id': instance.id,
      'angle': instance.angle,
      'color': instance.color,
      'fecha': instance.fecha.toIso8601String(),
    };
