import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/chat_model.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/viewmodels/chat_view_model.dart';
import 'package:moreyourbong/views/pages/chat/widgets/chatting_card.dart';

class ChatPage extends ConsumerStatefulWidget {
  ChatPage(this.party);
  Party party;
  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  double _bottomSheetHeight = 0;

  // BottomSheet의 자식 위젯에 GlobalKey 설정
  final GlobalKey _bottomSheetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 화면이 그려진 후 BottomSheet height 측정
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final bottomSheetContext = _bottomSheetKey.currentContext;
        if (bottomSheetContext != null) {
          final renderBox = bottomSheetContext.findRenderObject() as RenderBox;
          setState(() {
            _bottomSheetHeight = renderBox.size.height;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatVm = ref.watch(chatViewModel(widget.party.partyName).notifier);
    final chats = ref.read(chatViewModel(widget.party.partyName));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Color(0xFFF8F4E8),
          centerTitle: true,
          title: Text(
            widget.party.partyName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.fromLTRB(12, 20, 12, _bottomSheetHeight + 10),
          itemCount: 7,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return tempDataList[index];
          },
        ),
        bottomSheet: SafeArea(
          key: _bottomSheetKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey[300]!,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 4,
                    minLines: 1,
                    onChanged: (value) {
                      setState(() {
                        final bottomSheetContext = _bottomSheetKey.currentContext;
                        if (bottomSheetContext != null) {
                          final renderBox = bottomSheetContext.findRenderObject() as RenderBox;
                          setState(() {
                            _bottomSheetHeight = renderBox.size.height;
                          });
                        }
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[500]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xff4CAF50),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    print("send tap");
                    chatVm.sendMessage(
                      Chat(
                        id: "",
                        createdAt: DateTime.now(),
                        message: "새로운 메세지",
                        partyName: widget.party.partyName,
                        imageUrl: "",
                        sender: "오상구",
                        senderId: "senderID",
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
