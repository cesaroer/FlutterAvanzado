// To parse this JSON data, do
//
//     final usersLisrResponse = usersLisrResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

UsersLisrResponse usersLisrResponseFromJson(String str) =>
    UsersLisrResponse.fromJson(json.decode(str));

String usersLisrResponseToJson(UsersLisrResponse data) =>
    json.encode(data.toJson());

class UsersLisrResponse {
  bool ok;
  List<Usuario> usuarios;
  int desde;

  UsersLisrResponse({
    required this.ok,
    required this.usuarios,
    required this.desde,
  });

  UsersLisrResponse copyWith({
    bool? ok,
    List<Usuario>? usuarios,
    int? desde,
  }) =>
      UsersLisrResponse(
        ok: ok ?? this.ok,
        usuarios: usuarios ?? this.usuarios,
        desde: desde ?? this.desde,
      );

  factory UsersLisrResponse.fromJson(Map<String, dynamic> json) =>
      UsersLisrResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
        desde: json["desde"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
        "desde": desde,
      };
}
