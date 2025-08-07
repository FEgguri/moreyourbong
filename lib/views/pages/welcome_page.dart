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
        title: Text('모여봉'),
        backgroundColor: Color(0xFFFFCA28),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //프로필이미지
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  // shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 150,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          height: 200,
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
    );
  }
}
