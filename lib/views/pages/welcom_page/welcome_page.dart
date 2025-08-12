import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moreyourbong/viewmodels/global_user_view_model.dart';
import 'package:moreyourbong/viewmodels/user_view_model.dart';
import 'package:moreyourbong/views/pages/party_list/party_list_page.dart';
import 'package:moreyourbong/views/widgets/app_bar.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _triedSubmit = false; // 안내문 노출용
  bool _isLoading = false;

  @override
  void dispose() {
    //컨트롤러 메모리 누수 방지
    _nameController.dispose();
    super.dispose();
  }

//위치설청
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
    //이미지 로컬경로
    final localPath = ref.read(userViewModelProvider.notifier).localImagePath;
    final hasImage = (localPath != null && localPath.isNotEmpty);
    //이름 주소 확인(시작하기버튼용)
    final canStart =
        user.name.isNotEmpty && user.address.isNotEmpty && hasImage;
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        height: double.infinity,
        color: const Color(0xFFF8F4E8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            : const Icon(Icons.add,
                                size: 25, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (_triedSubmit && (localPath == null || localPath.isEmpty))
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('프로필 이미지를 선택하세요.',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),

                const SizedBox(height: 20),

                // 이름 입력
                TextFormField(
                  controller: _nameController,
                  onChanged: (v) =>
                      ref.read(userViewModelProvider.notifier).setName(v),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '이름을 입력하세요.';
                    if (v.trim().length < 2) return '이름은 2자 이상 입력하세요.';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: '이름을 입력하세요',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
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
                if (_triedSubmit && user.address.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('주소(내 동네)를 설정하세요.',
                          style: TextStyle(color: Colors.red)),
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
                onTap: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _triedSubmit = true;
                        });

                        final okForm =
                            _formKey.currentState?.validate() ?? false;
                        final localPath = ref
                            .read(userViewModelProvider.notifier)
                            .localImagePath;
                        final hasImage =
                            (localPath != null && localPath.isNotEmpty);
                        final hasAddress = user.address.isNotEmpty;

                        if (!okForm || !hasImage || !hasAddress) return;

                        setState(() => _isLoading = true);
                        try {
                          // 저장 성공 직후 부분 수정
                          await ref
                              .read(userViewModelProvider.notifier)
                              .saveToFirestore();
                          final saved = ref.read(userViewModelProvider);

                          if (!mounted) return;

                          if (saved.id.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('유저 저장 실패: ID 없음')),
                            );
                            return;
                          }

// 🔹 글로벌 상태에 저장
                          ref.read(globalUserProvider.notifier).setUser(saved);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('저장완료')),
                          );

                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PartyListPage(selectedAddress: saved.address),
                            ),
                          );
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('저장실패 : $e')),
                          );
                        } finally {
                          if (mounted) setState(() => _isLoading = false);
                        }
                      },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: canStart ? Color(0xFFF4B840) : Color(0xFF4F583B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: _isLoading
                          ? SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white)),
                            )
                          : Center(
                              child: Text(
                              '시작하기',
                              style: TextStyle(color: Colors.white),
                            )),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
