// lib/viewmodels/global_user_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/user_model.dart';
import 'package:moreyourbong/repositories/user_repository.dart';

class GlobalUserViewModel extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    // 앱 시작 시 초기 상태
    return null;
  }

  // Firestore에서 유저 정보 불러오기
  Future<void> fetchUser(String userId) async {
    final repo = ref.read(userRepositoryProvider);
    final user = await repo.fetchUser(userId);
    state = user;
  }

  // 이미 확보한 UserModel을 바로 전역 상태로 반영
  void setUser(UserModel user) {
    state = user;
  }
}

final globalUserProvider = NotifierProvider<GlobalUserViewModel, UserModel?>(
    () => GlobalUserViewModel());
