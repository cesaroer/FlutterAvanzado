import 'dart:io';

import 'package:chat_app/widgets/chat_messaje.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Hola mundoa asadfsfsdf asdfadfadfads asf", uuid: "13"),
    ChatMessage(text: "Hola mundo", uuid: "123"),
    ChatMessage(
        text:
            "Hola mundoks flksjflkjalkdjflkasjdlkfjalksfjlkasjdfkaldfjlkas asdlkfjlkasjflkasjfljsfdlk",
        uuid: "123"),
    ChatMessage(text: "Hola mundo", uuid: "123"),
  ];

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
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _messages[index];
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
                onChanged: (text) {
                  setState(() {
                    if (text.trim().length > 0) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: "Enviar mensaje"),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: !Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: const Text("Send"),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: const IconThemeData(color: Colors.blue),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: _isWriting
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(text: text, uuid: "123");

    setState(() {
      _isWriting = false;
      _messages.insert(0, newMessage);
    });
  }
}
