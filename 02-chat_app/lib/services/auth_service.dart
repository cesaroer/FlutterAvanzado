import 'dart:convert';
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authenticating = false;

  bool get authenticating => _authenticating;

  set authenticating(bool v) {
    this._authenticating = v;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.authenticating = true;

    final data = {
      "email": email,
      "password": password,
    };

    Uri uri = Uri.parse("${Environment.apiUrl}/login");

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': "application/json"});
    this.authenticating = false;

    if (resp.statusCode == 200) {
      final response = loginResponseFromJson(resp.body);
      this.usuario = response.body.usuarioDb;
      print(this.usuario.toJson());

      return true;
    } else {
      return false;
    }
  }
}
