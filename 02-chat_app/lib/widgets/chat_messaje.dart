import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uuid;

  ChatMessage({required this.text, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: this.uuid == "123" ? _myMessage() : _notMyMessage());
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 8, top: 4),
        padding: const EdgeInsets.all(8.0),
        child: Text(this.text, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          color: Color(0xff4d9ef6),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 8, right: 50, top: 4),
        padding: const EdgeInsets.all(8.0),
        child: Text(this.text, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
          color: Color(0xffe4e5e8),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
