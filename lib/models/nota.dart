import 'package:json_annotation/json_annotation.dart';

part 'nota.g.dart';

@JsonSerializable()
class Nota {
  String titulo, cuerpo;
  DateTime fecha;
  Nota({
    required this.titulo,
    required this.cuerpo,
    required this.fecha,
  });

  factory Nota.fromJson(Map<String, dynamic> json) => _$NotaFromJson(json);
  Map<String, dynamic> toJson() => _$NotaToJson(this);
}
