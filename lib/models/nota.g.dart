// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nota _$NotaFromJson(Map<String, dynamic> json) => Nota(
      titulo: json['titulo'] as String,
      cuerpo: json['cuerpo'] as String,
      fecha: json['fecha'] as String,
    );

Map<String, dynamic> _$NotaToJson(Nota instance) => <String, dynamic>{
      'titulo': instance.titulo,
      'cuerpo': instance.cuerpo,
      'fecha': instance.fecha,
    };
