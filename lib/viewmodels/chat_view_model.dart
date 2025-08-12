// 1. 상태 => List<Chat>

// 2. 뷰모델
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/chat_model.dart';
import 'package:moreyourbong/repositories/chat_repository.dart';

class ChatViewModel extends AutoDisposeFamilyNotifier<List<Chat>, String> {
  @override
  List<Chat> build(String arg) {
    listenStream();
    return [];
  }

  final chatRepo = ChatRepository();
  StreamSubscription<List<Chat>>? sub;

  Future<void> getChatMessages() async {
    final result = await chatRepo.getChatMessages(arg);
    state = result ?? [];
  }

  Future<bool> sendMessage(Chat newChat) async {
    final result = await chatRepo.sendMessage(
      sender: newChat.sender,
      senderId: newChat.senderId,
      partyName: newChat.partyName,
      partyId: newChat.partyId,
      message: newChat.message,
      imageUrl: newChat.imageUrl,
    );
    return result;
  }

  Future<bool> deleteMessageFromAll(String messageId) async {
    final result = await chatRepo.deleteMessage(messageId);
    return result;
  }

  void listenStream() {
    final stream = chatRepo.chatListStream(arg);
    final streamSubscription = stream.listen(
      (chatList) {
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
