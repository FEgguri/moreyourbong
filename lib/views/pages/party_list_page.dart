import 'package:flutter/material.dart';
import 'package:moreyourbong/views/widgets/party_list.dart';

class PartyListPage extends StatefulWidget {
  @override
  State<PartyListPage> createState() => _PartyListPageState();
}

class _PartyListPageState extends State<PartyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "OO시 OO구 OO동",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PartyList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 모임 만들기 페이지로 이동
        },
        backgroundColor: Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        splashColor: Color(0xFFFFCA28),
        child: Icon(Icons.person_add),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
