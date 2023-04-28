import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/material.dart';

part 'note.g.dart';

@JsonSerializable()
@immutable
class Note {
  final String title, body, id;
  final int angle, color;
  final DateTime date;
  const Note({
    required this.title,
    required this.body,
    required this.date,
    required this.id,
    required this.color,
    required this.angle,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
  Note copyWith({
    String? title,
    String? body,
    String? id,
    int? color,
    int? angle,
    DateTime? date,
  }) {
    return Note(
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
      id: id ?? this.id,
      color: color ?? this.color,
      angle: angle ?? this.angle,
    );
  }
}
