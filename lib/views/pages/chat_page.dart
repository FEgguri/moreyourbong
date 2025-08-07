import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("ChatPage"),
      ),
      bottomSheet: SafeArea(
        child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }
}
