// location_service.dart

import 'package:geolocator/geolocator.dart';

class LocationService {
  /// 현재 위치 정보를 얻는다. 위치 서비스 꺼짐, 권한 거부 상태에 따라 예외를 던진다.
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. 위치 서비스가 켜져 있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //이게 꺼져 있으면 아무것도 못함 → 즉시 예외 발생.
    if (!serviceEnabled) {
      throw Exception('위치 서비스가 꺼져있습니다. 설정에서 켜주세요.');
    }

    // 2. 위치 권한 확인
    //   권한 상태는 다음 중 하나
    // 	denied: 거절된 상태 (재요청 가능)
    // 	deniedForever: 영구 거절 (설정 앱으로 가야 함)
    // 	whileInUse 또는 always: 사용 가능
    permission = await Geolocator.checkPermission();

    // 2-1. 영구적으로 거부된 상태
    // 기기에서 옵션이 꺼져있을때 예외 발생하기때문에 기기 설정에서 권한 설정을 해야함
    if (permission == LocationPermission.deniedForever) {
      throw Exception('위치 권한이 영구적으로 거부되었습니다. 설정에서 수동으로 허용해야 합니다.');
    }

    // 2-2. 일시적으로 거부된 상태
    if (permission == LocationPermission.denied) {
      //requestPermission()을 통해 다시 요청.
      permission = await Geolocator.requestPermission();

      //요청 후에도 denied거나 deniedForever면 예외 처리.
      if (permission == LocationPermission.denied) {
        throw Exception('위치 권한이 거부되었습니다.');
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('위치 권한이 영구적으로 거부되었습니다. 설정에서 허용해야 합니다.');
      }
    }

    // 3. 현재 위치 얻기
    //권한과 서비스 모두 OK일 때 위치를 가져옴
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        //LocationAccuracy.high는 고정밀 GPS 기반 위치를 의미함.
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}
