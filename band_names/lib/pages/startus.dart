import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    //socketService.socket.emit(event);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Status server ${socketService.serverStatus}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final map = socketService.emit(
            "emitir-mensaje",
            {'nombre': "Flutter", "mensake": "Hola desde flutter"},
          );
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
