import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
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
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
