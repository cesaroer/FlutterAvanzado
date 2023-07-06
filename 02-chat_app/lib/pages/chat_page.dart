import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.blueAccent,
              child: Text(
                "TE",
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 3),
            Text(
              "Test User",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Text("$index");
                },
                reverse: true,
              ),
            ),
            Divider(height: 2),
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (text) {},
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar mensaje"),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: !Platform.isIOS
                  ? CupertinoButton(child: Text("Send"), onPressed: () {})
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send, color: Colors.blue),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    print(text);
    _textController.clear();
    _focusNode.requestFocus();
  }
}
