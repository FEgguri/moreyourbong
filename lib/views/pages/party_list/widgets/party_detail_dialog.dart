import 'package:flutter/material.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/views/pages/chat/chat_page.dart';

Future<void> showPartyDetail(BuildContext context, Party party) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.only(top: 30),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      title: Text(
        party.partyName,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          party.content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 98, 98, 98),
            fontSize: 12,
          ),
        ),
      ),
      actions: [
        // 취소 버튼
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: const Text('취소'),
        ),

        // 확인 버튼
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Future.microtask(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatPage(party)));
            });
          },
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF4CAF50),
              overlayColor: Color(0xFFFFCA28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: const Text(
            "채팅하기",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
