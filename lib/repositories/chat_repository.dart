import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moreyourbong/models/chat_model.dart';

class ChatRepository {
  final firestore = FirebaseFirestore.instance;

  Future<List<Chat>?> getChatMessages(String partyId) async {
    try {
      final col = firestore.collection("Chat");
      final result = await col.get();
      final docs = result.docs;

      return docs
          .map((doc) {
            final map = doc.data();
            final newMap = {
              "id": doc.id,
              ...map,
            };
            return Chat.fromJson(newMap);
          })
          .where((chat) => chat.partyId == partyId)
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> sendMessage({
    required String sender,
    required String senderId,
    required String partyName,
    required String partyId,
    required String message,
    required String? imageUrl,
  }) async {
    try {
      final collection = firestore.collection("Chat");
      final doc = collection.doc();
      await doc.set({
        "id": doc.id,
        "sender": sender,
        "senderId": senderId,
        "partyName": partyName,
        "partyId": partyId,
        "message": message,
        "imageUrl": imageUrl,
        "createdAt": DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteMessage(String messageId) async {
    try {
      //
      final collection = firestore.collection("Chat");
      final doc = collection.doc(messageId);
      await doc.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Chat>> chatListStream(String partyId) {
    try {
      //
      final collection = firestore.collection("Chat").where("partyId", isEqualTo: partyId).orderBy("createdAt", descending: false);
      final stream = collection.snapshots();
      final newStream = stream.map((event) {
        return event.docs.map((e) {
          return Chat.fromJson({
            "id": e.id,
            ...e.data(),
          });
        }).toList();
      });
      return newStream;
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }
}
