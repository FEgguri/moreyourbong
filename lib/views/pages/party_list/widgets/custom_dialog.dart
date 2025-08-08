import 'package:flutter/material.dart';
import 'package:moreyourbong/views/pages/chat/chat_page.dart';

Future<void> showCustomDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.only(top: 30),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      title: const Text(
        "채팅방에 참여하시겠습니까?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: const Text(
        "내 프로필이 채팅방 참여자에게 보여집니다.\n바르고 고운말을 사용합시다.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromARGB(255, 98, 98, 98),
          fontSize: 12,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatPage()));
          },
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF4CAF50),
              overlayColor: Color(0xFFFFCA28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: const Text(
            '확인',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
