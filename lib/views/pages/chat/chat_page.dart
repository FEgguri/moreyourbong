import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/chat_model.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/models/user_model.dart';
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

  final messageController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 화면이 그려진 후 BottomSheet height 측정
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
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
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatVm = ref.read(chatViewModel(widget.party.id).notifier);
    final chats = ref.watch(chatViewModel(widget.party.id));
    print(widget.party.id);
    print(widget.party.id == "kuXkfaog4cgSML4xIJmQ");

    ref.listen<List<Chat>>(
      chatViewModel(widget.party.id),
      (previous, next) {
        if (previous == null || next.length > previous.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            }
          });
        }
      },
    );

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
          controller: scrollController,
          itemCount: chats.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return ChattingCard(
              name: chats[index].sender,
              message: chats[index].message,
              time: chats[index].createdAt.toString(),
              imageUrl: chats[index].imageUrl,
              isMine: user.id == chats[index].senderId,
            );
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
                    controller: messageController,
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
                    chatVm
                        .sendMessage(
                      Chat(
                        id: "",
                        createdAt: DateTime.now(),
                        message: messageController.text,
                        partyName: widget.party.partyName,
                        imageUrl: user.img,
                        sender: user.name,
                        senderId: user.id,
                        partyId: widget.party.id,
                      ),
                    )
                        .then((_) {
                      messageController.text = "";
                      // 전송 후 스크롤 자동으로 밑으로
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      // });
                    });
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

// UserModel user = UserModel(id: "senderId", address: "경기도 의정부시", name: "오상칠");
// UserModel user = UserModel(id: "Nh4TLr0eMicXhd2fof9m", address: "경기도 의정부시", name: "오상팔");
UserModel user = UserModel(
  id: "cbPEwXPCa0z0ZL8T4q1N",
  address: "경기도 의정부시",
  name: "오상구",
  img: "https://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg",
);
