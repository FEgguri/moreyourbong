import 'package:flutter/material.dart';
import 'package:moreyourbong/services/location_service.dart';
import 'package:moreyourbong/services/vworld_service.dart';
import 'package:moreyourbong/views/widgets/app_bar.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _locationName; // 동네 이름 저장할 상태 변수

  @override
  void dispose() {
    //컨트롤러 메모리 누수 방지
    _nameController.dispose();
    super.dispose();
  }

  void _handleLocationButtonPressed() async {
    try {
      final position = await LocationService.getCurrentLocation();
      final locationName = await VworldService.getLocationName(
        position.longitude,
        position.latitude,
      );
      setState(() {
        _locationName = locationName; // 상태 업데이트
      });
      print('내 동네: $locationName');
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        color: Color(0xFFF8F4E8),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color(0xFFF8F4E8)),
                  child: Center(
                    child: Container(
                      //프로필이미지
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Color(0xFFE8E2D3),

                        // shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: '이름을 입력하세요',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _handleLocationButtonPressed();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4B840),
                      borderRadius: BorderRadius.circular(15),
                      //border: Border.all(width: 1),
                    ),
                    child: Center(child: Text('내 동네 설정')),
                  ),
                ),
                if (_locationName != null) (Text('$_locationName'))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF8F4E8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            height: 100,
            child: GestureDetector(
                onTap: () {
                  print('바텀버튼');
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F583B),
                      borderRadius: BorderRadius.circular(15),
                      //border: Border.all(width: 1),
                    ),
                    child: Center(
                        child: Text(
                      '시작하기',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
