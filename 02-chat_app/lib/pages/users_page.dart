import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final users = [
    Usuario(nombre: "User 1", online: true, email: "uno@gmail.com", uuid: "1"),
    Usuario(nombre: "User 2", online: false, email: "dos@gmail.com", uuid: "2"),
    Usuario(nombre: "User 3", online: true, email: "tres@gmail.com", uuid: "3"),
    Usuario(
        nombre: "User 4", online: false, email: "cuatro@gmail.com", uuid: "4"),
    Usuario(
        nombre: "User 5", online: true, email: "cinco@gmail.com", uuid: "5"),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.nombre,
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "login");
            AuthService.deleteToken();
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            //child: Icon(Icons.check_circle, color: Colors.blue),
            child: const Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          waterDropColor: Colors.blue,
          complete: Icon(
            Icons.check,
            color: Colors.blue,
          ),
        ),
        child: _usersListView(),
      ),
    );
  }

  ListView _usersListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _userListView(users[index]);
      },
      itemCount: users.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  ListTile _userListView(Usuario user) {
    return ListTile(
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
