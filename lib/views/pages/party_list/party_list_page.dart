import 'package:flutter/material.dart';
import 'package:moreyourbong/views/pages/create_party_page.dart';
import 'package:moreyourbong/views/pages/party_list/widgets/party_list.dart';

class PartyListPage extends StatefulWidget {
  final String selectedAddress;
  PartyListPage({required this.selectedAddress});

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
          widget.selectedAddress,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PartyList(selectedAddress: widget.selectedAddress),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePartyPage()));
        },
        backgroundColor: Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        splashColor: Color(0xFFFFCA28),
        shape: const CircleBorder(),
        child: Icon(Icons.person_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
