// User ViewModel

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/user_model.dart';
import 'package:moreyourbong/services/location_service.dart';
import 'package:moreyourbong/services/vworld_service.dart';

final userViewModelProvider =
    NotifierProvider<UserViewModel, UserModel>(() => UserViewModel());

class UserViewModel extends Notifier<UserModel> {
  @override
  UserModel build() => UserModel.empty(); //초기상태

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  Future<void> setAddressFromCurrentLocation() async {
    final pos = await LocationService.getCurrentLocation();
    final addr = await VworldService.getLocationName(
      pos.longitude,
      pos.latitude,
    );
    state = state.copyWith(address: addr);
  }

  void setImg(String? url) {
    state = state.copyWith(img: url);
  }
}
