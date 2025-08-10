// 1. 상태 => List<Chat>

// 2. 뷰모델
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/chat_model.dart';
import 'package:moreyourbong/repositories/chat_repository.dart';

class ChatViewModel extends AutoDisposeFamilyNotifier<List<Chat>, String> {
  @override
  List<Chat> build(String arg) {
    listenStream(arg);
    return [];
  }

  final chatRepo = ChatRepository();
  StreamSubscription<List<Chat>>? sub;

  Future<void> getChatMessages(String partyName) async {
    final result = await chatRepo.getChatMessages(partyName);
    state = result ?? [];
  }

  Future<bool> sendMessage(Chat newChat) async {
    final result = await chatRepo.sendMessage(
      sender: newChat.sender,
      senderId: newChat.senderId,
      partyName: newChat.partyName,
      message: newChat.message,
      imageUrl: newChat.imageUrl,
    );
    return result;
  }

  void listenStream(String partyName) {
    final stream = chatRepo.chatListStream(partyName);
    final streamSubscription = stream.listen(
      (chatList) {
        print("ddd");
        state = chatList;
      },
    );

    ref.onDispose(() {
      streamSubscription.cancel();
    });
  }
}

// 3. 뷰모델 관리자
final chatViewModel = NotifierProvider.autoDispose.family<ChatViewModel, List<Chat>, String>(() {
  return ChatViewModel();
});
