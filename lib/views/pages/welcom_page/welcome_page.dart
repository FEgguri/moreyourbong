import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/viewmodels/user_view_model.dart';
import 'package:moreyourbong/views/widgets/app_bar.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  //final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    //컨트롤러 메모리 누수 방지
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _setAddress() async {
    try {
      await ref
          .read(userViewModelProvider.notifier)
          .setAddressFromCurrentLocation();
      final addr = ref.read(userViewModelProvider).address;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('현재위치: $addr'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('에러: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //유저 프로바이더 구독
    final user = ref.watch(userViewModelProvider);
//이름 주소 확인(시작하기버튼용)
    final canStart = user.name.isNotEmpty && user.address.isNotEmpty;
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
                      decoration: const BoxDecoration(
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
                  onChanged: (v) =>
                      ref.read(userViewModelProvider.notifier).setName(v),
                  decoration: InputDecoration(
                      labelText: '이름을 입력하세요',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _setAddress,
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
                if (user.address.isNotEmpty) Text(user.address),
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
                onTap: canStart
                    ? () async {
                        try {
                          print('리스트페이지로 이동');
                          //firestore저장
                          await ref
                              .read(userViewModelProvider.notifier)
                              .saveToFirestore();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('저장완료'),
                            ),
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => const PartyListPage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('저장실패 : $e'),
                            ),
                          );
                        }
                      }
                    : null,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: canStart ? Color(0xFFF4B840) : Color(0xFF4F583B),
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
