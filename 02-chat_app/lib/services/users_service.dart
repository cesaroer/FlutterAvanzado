import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      Uri uri = Uri.parse("${Environment.apiUrl}/users");
      final token = await AuthService.getToken();
      final resp = await http.get(
        uri,
        headers: {
          "x-token": token!,
        },
      );

      final usrsResponse = usersLisrResponseFromJson(resp.body);
      return usrsResponse.usuarios;
    } catch (e) {
      return [];
    }
    return [];
  }
}
