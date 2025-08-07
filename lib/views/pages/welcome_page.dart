import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    //컨트롤러 메모리 누수 방지
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F4E8),
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.15),
        centerTitle: true, // 가운데 정렬
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 55,
              width: 55,
              fit: BoxFit.contain,
            ),
            //SizedBox(width: 8),
            Text(
              'MoreYourBong',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
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
                    print('버튼');
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
                      color: Color(0xFF4F583B),
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
