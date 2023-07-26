// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool ok;
  String msg;
  Body body;

  LoginResponse({
    required this.ok,
    required this.msg,
    required this.body,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msg: json["msg"],
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "body": body.toJson(),
      };
}

class Body {
  Usuario usuarioDb;
  String token;

  Body({
    required this.usuarioDb,
    required this.token,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        usuarioDb: Usuario.fromJson(json["usuarioDB"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "usuarioDB": usuarioDb.toJson(),
        "token": token,
      };
}
