// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      title: json['title'] as String,
      body: json['body'] as String,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String,
      color: json['color'] as int,
      angle: json['angle'] as int,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'id': instance.id,
      'angle': instance.angle,
      'color': instance.color,
      'date': instance.date.toIso8601String(),
    };
