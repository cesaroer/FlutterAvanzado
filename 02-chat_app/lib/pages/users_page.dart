import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../services/socket_service.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Usuario> users = [];
  final userService = UsersService();

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

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
            socketService.dissconnect();
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
              child: (socketService.serverStatus != ServerStatus.Online)
                  ? Icon(Icons.offline_bolt, color: Colors.red)
                  : Icon(Icons.check_circle, color: Colors.blue))
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
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.chatUser = user;

        Navigator.pushNamed(context, "chat");
      },
    );
  }

  _cargarUsuarios() async {
    this.users = await userService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
