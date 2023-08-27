// To parse this JSON data, do
//
//     final renewReponse = renewReponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

RenewReponse renewReponseFromJson(String str) =>
    RenewReponse.fromJson(json.decode(str));

String renewReponseToJson(RenewReponse data) => json.encode(data.toJson());

class RenewReponse {
  bool ok;
  Body body;

  RenewReponse({
    required this.ok,
    required this.body,
  });

  RenewReponse copyWith({
    bool? ok,
    Body? body,
  }) =>
      RenewReponse(
        ok: ok ?? this.ok,
        body: body ?? this.body,
      );

  factory RenewReponse.fromJson(Map<String, dynamic> json) => RenewReponse(
        ok: json["ok"],
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "body": body.toJson(),
      };
}

class Body {
  String msg;
  Usuario user;
  String token;

  Body({
    required this.msg,
    required this.user,
    required this.token,
  });

  Body copyWith({
    String? msg,
    Usuario? user,
    String? token,
  }) =>
      Body(
        msg: msg ?? this.msg,
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        msg: json["msg"],
        user: Usuario.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "user": user.toJson(),
        "token": token,
      };
}
