import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/user_model.dart';
import 'package:moreyourbong/repositories/storage_repository.dart';
import 'package:moreyourbong/repositories/user_repository.dart';
import 'package:moreyourbong/services/location_service.dart';
import 'package:moreyourbong/services/vworld_service.dart';

final userViewModelProvider =
    NotifierProvider<UserViewModel, UserModel>(() => UserViewModel());

class UserViewModel extends Notifier<UserModel> {
  String? _localImagePath; //로컬이미지미리보리용
  String? get localImagePath => _localImagePath;

  @override
  UserModel build() => UserModel.empty();

  void setName(String name) => state = state.copyWith(name: name);

  void setLocalImagePath(String path) {
    _localImagePath = path;
    // 미리보기 위해 img에 로컬 표시용
    // state = state.copyWith(img: path);
  }

  Future<void> setAddressFromCurrentLocation() async {
    final pos = await LocationService.getCurrentLocation();
    final addr =
        await VworldService.getLocationName(pos.longitude, pos.latitude);
    state = state.copyWith(address: addr);
  }

  // void setImg(String? url) => state = state.copyWith(img: url);

  /// Firestore 저장: id가 비어있으면 여기서 생성해서 고정
  Future<void> saveToFirestore() async {
    // 필수 필드 검증
    if (state.name.isEmpty) {
      throw Exception('이름을 입력하세요.');
    }
    if (state.address.isEmpty) {
      throw Exception('주소(내 동네)를 설정하세요.');
    }
    // 이미지: 업로드 대기 중(로컬 경로) 또는 이미 저장된 URL 둘 중 하나는 있어야 함
    final hasLocal = (_localImagePath != null && _localImagePath!.isNotEmpty);
    final hasRemote = (state.img?.isNotEmpty ?? false);
    if (!hasLocal && !hasRemote) {
      throw Exception('프로필 이미지를 선택하세요.');
    }

    try {
      // ...현재 로직
      final storage = ref.read(storageRepositoryProvider);
      final repo = ref.read(userRepositoryProvider);
      var current = state;

      if (current.id.isEmpty) {
        // 컬렉션 'User'에서 새 문서 id 생성
        final newId = FirebaseFirestore.instance.collection('User').doc().id;
        current = current.copyWith(id: newId);
      }
      // 로컬 이미지가 있으면 업로드
      if (_localImagePath != null && _localImagePath!.isNotEmpty) {
        final url = await storage.uploadUserProfile(
          userId: current.id,
          file: File(_localImagePath!),
        );
        current = current.copyWith(img: url);
        _localImagePath = null; // 소모 완료
      }
      state = current;
      await repo.createOrUpdateUser(current);
    } on FirebaseException catch (e) {
      print(' Firebase 오류: ${e.code}, ${e.message}');

      rethrow;
    } catch (e) {
      print('⚠️ 알 수 없는 오류: $e');

      rethrow;
    }
  }
}

// DI
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseFirestore.instance);
});
final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  return StorageRepository(FirebaseStorage.instance);
});
