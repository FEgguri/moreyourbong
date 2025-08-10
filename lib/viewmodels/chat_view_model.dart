// 1. 상태 => List<Chat>

// 2. 뷰모델
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
      imageUrl: newChat.profileImgUrl,
    );
    return result;
  }

  void listenStream(String partyName) {
    final stream = chatRepo.chatListStream(partyName);
    final streamSubscription = stream.listen(
      (chatList) {
        state = chatList;
      },
    );
  }
}

// 3. 뷰모델 관리자