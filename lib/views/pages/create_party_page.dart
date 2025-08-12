// lib/views/pages/create_party_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/repositories/party_repository.dart';
import 'package:moreyourbong/viewmodels/party_view_medel.dart';
import 'package:moreyourbong/views/widgets/app_bar.dart';

class CreatePartyPage extends ConsumerStatefulWidget {
  const CreatePartyPage({
    super.key,
    required this.selectedAddress,
  });

  final String selectedAddress;

  @override
  ConsumerState<CreatePartyPage> createState() => _CreatePartyPageState();
}

class _CreatePartyPageState extends ConsumerState<CreatePartyPage> {
  final _nameCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _createParty() async {
    final name = _nameCtrl.text.trim();
    final content = _contentCtrl.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('모임 이름을 입력하세요.')));
      return;
    }
    if (content.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('모임 설명을 입력하세요.')));
      return;
    }

    setState(() => _submitting = true);
    try {
      // 문서 ID 선점
      final docId = FirebaseFirestore.instance
          .collection('parties')
          .doc(widget.selectedAddress)
          .collection('items')
          .doc()
          .id;

      final ok = await PartyRepository().addParty(
        id: docId,
        partyName: name,
        address: widget.selectedAddress,
        content: content,
      );
      if (!ok) throw Exception('저장 실패');

      // 리스트 갱신
      await ref
          .read(partyViewModelProvider(widget.selectedAddress).notifier)
          .addParty(widget.selectedAddress);

      // 채팅 페이지로 이동 (필요 시 주석 해제)
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (_) => ChatPage(partyId: docId, address: widget.selectedAddress),
      // ));

      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('모임이 생성되었습니다.')));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('모임 생성 실패: $e')));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = !_submitting;

    return Scaffold(
      appBar: appBar(context),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(0xFFF8F4E8),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(
                        labelText: '모임 이름',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _contentCtrl,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: '모임 설명',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('위치: ${widget.selectedAddress}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF8F4E8),
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: canSubmit ? _createParty : null,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color:
                  canSubmit ? const Color(0xFFF4B840) : const Color(0xFF4F583B),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(
              _submitting ? '생성 중...' : '모임 만들기',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
