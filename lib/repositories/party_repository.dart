import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moreyourbong/models/party_model.dart';

class PartyRepository {
  // 모임 불러오기
  Future<List<Party>> getAll(String address) async {
    // 통신 오류 처리
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 경로 : parties > address > items 여기서 불러오기
      final collectionRef = firestore.collection("parties").doc(address).collection("items");

      final snapshot = await collectionRef.get();
      final documentSnapshot = snapshot.docs;
      final iterable = documentSnapshot.map((e) {
        // ID 필요시 아래 코드 사용하기
        final map = {"id": e.id, ...e.data()};
        // final map = e.data();
        return Party.fromJson(map);
      });

      final list = iterable.toList();
      return list;
    }
    // Firestore 오류 및 예외 처리
    on FirebaseException catch (e) {
      print("Firestore Error : ${e.message}");
      return [];
    }
    // 그 외 처리
    catch (e) {
      return [];
    }
  }

  // 모임 등록하기
  Future<bool> addParty({
    required String id,
    required String partyName,
    required String address,
    required String content,
  }) async {
    // 통신 오류 처리
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 경로 : parties > address > items 여기에 저장
      final collectionRef = firestore.collection("parties").doc(address).collection("items");
      final docRef = collectionRef.doc();

      final map = {
        "id": id,
        "partyName": partyName,
        "address": address,
        "content": content,
      };

      await docRef.set(map);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
