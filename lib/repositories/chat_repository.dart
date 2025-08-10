import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moreyourbong/models/chat_model.dart';

class ChatRepository {
  Future<List<Chat>?> getChatMessages(String partyName) async {
    try {
      final firestore = FirebaseFirestore.instance;
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
          .where((chat) => chat.partyName == partyName)
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
    required String message,
    required String imageUrl,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection("Chat");
      final doc = collection.doc();
      await doc.set({
        "sender": sender,
        "senderId": senderId,
        "partyName": partyName,
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

  Stream<List<Chat>> chatListStream(String partyName) {
    try {
      //
      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection("Chat").where("partName", isEqualTo: partyName).orderBy("createdAt", descending: true);
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
