import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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

//위치설청
  Future<void> _setAddress() async {
    try {
      await ref.read(userViewModelProvider.notifier).setAddressFromCurrentLocation();
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

//이미지 선택 후 화면에 보여주기
  Future<void> _pickAndUpload() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    // 업로드 X, 로컬 경로만 저장해서 미리보기
    ref.read(userViewModelProvider.notifier).setLocalImagePath(picked.path);
    setState(() {}); // 미리보기 갱신
  }

  @override
  Widget build(BuildContext context) {
    //유저 프로바이더 구독
    final user = ref.watch(userViewModelProvider);
//이름 주소 확인(시작하기버튼용)
    final canStart = user.name.isNotEmpty && user.address.isNotEmpty;
    //이미지 로컬경로
    final localPath = ref.read(userViewModelProvider.notifier).localImagePath;

    return Scaffold(
      appBar: appBar(context),
      body: Container(
        height: double.infinity,
        color: const Color(0xFFF8F4E8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 프로필 박스
              Container(
                height: 240,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: const Color(0xFFF8F4E8),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: _pickAndUpload,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8E2D3),
                      ),
                      child: (localPath != null && localPath.isNotEmpty)
                          // 1. 로컬 경로가 있으면 로컬 파일 표시
                          ? Image.file(
                              File(localPath),
                              fit: BoxFit.cover,
                            )
                          // 2. 없으면 아이콘표시
                          : const Icon(Icons.add, size: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 이름 입력
              TextFormField(
                controller: _nameController,
                onChanged: (v) => ref.read(userViewModelProvider.notifier).setName(v),
                decoration: InputDecoration(
                  labelText: '이름을 입력하세요',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),

              const SizedBox(height: 20),

              // 내 동네 설정
              GestureDetector(
                onTap: _setAddress,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4B840),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(child: Text('내 동네 설정')),
                ),
              ),

              if (user.address.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(user.address),
              ],
            ],
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
                        print(canStart);
                        try {
                          print('리스트페이지로 이동');
                          //firestore저장
                          await ref.read(userViewModelProvider.notifier).saveToFirestore();

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
