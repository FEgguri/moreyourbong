import 'dart:convert';
import 'package:http/http.dart' as http;

class VworldService {
  static Future<String> getLocationName(
      double longitude, double latitude) async {
    const String apiKey = '4C045D9F-AC52-37A8-BAEE-68ABF082C03A';

    //VWorld의 주소 변환 API 호출용 URL.
    final String url = 'https://api.vworld.kr/req/address'
        '?service=address'
        '&request=getAddress'
        '&point=$longitude,$latitude'
        //format=json: 응답을 JSON 형태로 받는다.
        '&format=json'
        //type=both: 도로명/지번 주소 둘 다 요청하되, 여기서는 지번 주소 정보 활용
        '&type=both'
        '&key=$apiKey';

    //위 URL로 GET 요청 전송.
    final response = await http.get(Uri.parse(url));

    //응답 성공하면 body를 JSON으로 변환
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final items = jsonBody['response']['result'];
      if (items.isNotEmpty) {
        final String si = items[0]['structure']['level1']; // 시
        final String gu = items[0]['structure']['level2']; // 구
        return '$si $gu';
      } else {
        throw Exception('주소 정보를 찾을 수 없습니다.');
      }
    } else {
      throw Exception('VWorld API 오류: ${response.statusCode}');
    }
  }
}
