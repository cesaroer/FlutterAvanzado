// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  bool ok;
  Body body;

  RegisterResponse({
    required this.ok,
    required this.body,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        ok: json["ok"],
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "body": body.toJson(),
      };
}

class Body {
  Usuario usuarioDB;
  String token;

  Body({
    required this.usuarioDB,
    required this.token,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        usuarioDB: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuarioDB.toJson(),
        "token": token,
      };
}
