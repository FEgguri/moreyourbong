import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moreyourbong/firebase_options.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/views/pages/chat/chat_page.dart';
import 'package:moreyourbong/views/pages/party_list/party_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp((const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(
        Party(
          id: "kuXkfaog4cgSML4xIJmQ",
          address: "서울시 강남구 무슨동",
          content: "💕 모여서 봉사 할동 하실 분들 환영합니다~ 채팅방 참여하시고 같이 봉사 활동 해요!",
          partyName: "행복한 모임 이름",
        ),
      ),
    );
  }
}
