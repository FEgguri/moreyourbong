import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/user_model.dart';
import 'package:moreyourbong/repositories/user_repository.dart';
import 'package:moreyourbong/services/location_service.dart';
import 'package:moreyourbong/services/vworld_service.dart';

final userViewModelProvider =
    NotifierProvider<UserViewModel, UserModel>(() => UserViewModel());

class UserViewModel extends Notifier<UserModel> {
  @override
  UserModel build() => UserModel.empty();

  void setName(String name) => state = state.copyWith(name: name);

  Future<void> setAddressFromCurrentLocation() async {
    final pos = await LocationService.getCurrentLocation();
    final addr =
        await VworldService.getLocationName(pos.longitude, pos.latitude);
    state = state.copyWith(address: addr);
  }

  void setImg(String? url) => state = state.copyWith(img: url);

  /// Firestore 저장: id가 비어있으면 여기서 생성해서 고정
  Future<void> saveToFirestore() async {
    var current = state;

    if (current.id.isEmpty) {
      // 컬렉션 'User'에서 새 문서 id 생성
      final newId = FirebaseFirestore.instance.collection('User').doc().id;
      current = current.copyWith(id: newId);
      state = current;
    }

    final repo = ref.read(userRepositoryProvider);
    await repo.createOrUpdateUser(current);
  }
}
