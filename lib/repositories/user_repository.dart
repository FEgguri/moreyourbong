import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db;
  UserRepository(this._db);

  /// users
  CollectionReference<Map<String, dynamic>> get _col => _db.collection('User');

  /// upsert: user.id 로 문서 고정
  Future<void> createOrUpdateUser(UserModel user) async {
    await _col.doc(user.id).set(
          user.toMap(),
          SetOptions(merge: true),
        );
  }

  //이미지업로드
  Future<void> updateProfileImageUrl({
    required String userId,
    required String url,
  }) async {
    await _col.doc(userId).set(
      {'img': url},
      SetOptions(merge: true),
    );
  }

  /// 실시간 구독
  Stream<UserModel?> watchUser(String userId) {
    return _col.doc(userId).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      final data = {...snap.data()!, 'id': snap.id};
      return UserModel.fromMap(data);
    });
  }

  /// 단건 조회
  Future<UserModel?> fetchUser(String userId) async {
    final doc = await _col.doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    final data = {...doc.data()!, 'id': doc.id};
    return UserModel.fromMap(data);
  }
}

/// DI
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseFirestore.instance);
});
