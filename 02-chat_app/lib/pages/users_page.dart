import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(name: "User 1", online: true, email: "uno@gmail.com", uuid: "1"),
    User(name: "User 2", online: false, email: "dos@gmail.com", uuid: "2"),
    User(name: "User 3", online: true, email: "tres@gmail.com", uuid: "3"),
    User(name: "User 4", online: false, email: "cuatro@gmail.com", uuid: "4"),
    User(name: "User 5", online: true, email: "cinco@gmail.com", uuid: "5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My name",
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              //child: Icon(Icons.check_circle, color: Colors.blue),
              child: Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(users[index].name),
              leading: CircleAvatar(
                child: Text(users[index].name.substring(0, 2)),
              ),
              trailing: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: users[index].online ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            );
          },
          itemCount: users.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ));
  }
}
