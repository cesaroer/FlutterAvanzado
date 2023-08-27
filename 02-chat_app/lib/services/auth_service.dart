import 'dart:convert';
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/register_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;

  set authenticating(bool v) {
    this._authenticating = v;
    notifyListeners();
  }

  // Getters del token estaticos
  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
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
      await logout();
      await _guardarToken(response.body.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String email, String password, String nombre) async {
    this.authenticating = true;

    final data = {
      "nombre": nombre,
      "email": email,
      "password": password,
    };

    Uri uri = Uri.parse("${Environment.apiUrl}/login/new");

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': "application/json"});
    this.authenticating = false;

    if (resp.statusCode == 200) {
      final response = registerResponseFromJson(resp.body);
      this.usuario = response.body.usuarioDB;
      await logout();
      await _guardarToken(response.body.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody["msg"];
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
