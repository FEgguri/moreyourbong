import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moreyourbong/firebase_options.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/views/pages/chat/chat_page.dart';
import 'package:moreyourbong/views/pages/party_list/party_list_page.dart';
import 'package:moreyourbong/views/pages/welcom_page/welcome_page.dart';

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
      home: WelcomePage(),
    );
  }
}
