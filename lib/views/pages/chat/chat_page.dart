import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/chat_model.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/models/user_model.dart';
import 'package:moreyourbong/utils/date_time_utils.dart';
import 'package:moreyourbong/viewmodels/chat_view_model.dart';
import 'package:moreyourbong/viewmodels/global_user_view_model.dart';
import 'package:moreyourbong/views/pages/chat/widgets/chatting_card.dart';

class ChatPage extends ConsumerStatefulWidget {
  ChatPage(this.party);
  Party party;
  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  double _bottomSheetHeight = 0;
  DateTime lastSendTime = DateTime(0);
  bool lastSendIsMine = false;
  String lastSenderId = "";

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
    final user = ref.watch(globalUserProvider);
    // final user = null;
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text("유저 정보가 존재하지 않습니다."),
        ),
      );
    }

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
        body: ListView.builder(
          padding: EdgeInsets.fromLTRB(12, 20, 12, _bottomSheetHeight + 10),
          controller: scrollController,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            // print(chats.length);
            // print(hiddenMessageIds.length);
            // for (int j = 0; j < hiddenMessageIds.length; j++) {
            //   print(hiddenMessageIds[j]);
            // }
            String currentMessageId = chats[index].id;
            if (hiddenMessageIds.contains(currentMessageId)) {
              return SizedBox();
            }
            String currentSenderId = chats[index].senderId;
            DateTime currentMessageSendTime = chats[index].createdAt;
            String time = currentMessageSendTime.toString();
            bool showProfile = true;

            if (index > 0) {
              int i = index - 1;
              String nextSenderId = chats[i].senderId;
              DateTime nextMessageSendTime = chats[i].createdAt;
              if (currentSenderId == nextSenderId) {
                final diff = currentMessageSendTime.difference(nextMessageSendTime);
                if (diff.inMinutes < 1) {
                  if (!hiddenMessageIds.contains(chats[i].id)) {
                    showProfile = false;
                  }
                }
              }
            }

            if (index < chats.length - 1) {
              int i = index + 1;
              // 다음 메세지가 1분 이내의 메세지이지만 내 기기에서 삭제한 메세지인 경우 대비
              while (i < chats.length && hiddenMessageIds.contains(chats[i].id)) {
                i++;
              }
              // i번째 메세지가 내 기기에서 삭제된 경우 다시 전으로 찾아가기
              if (i == chats.length) {
                i--;
                while (hiddenMessageIds.contains(chats[i].id)) {
                  i--;
                }
              }
              if (index != i) {
                String nextSenderId = chats[i].senderId;
                DateTime nextMessageSendTime = chats[i].createdAt;
                if (currentSenderId == nextSenderId) {
                  final diff = nextMessageSendTime.difference(currentMessageSendTime);
                  if (diff.inMinutes < 1) {
                    time = "";
                  }
                }
              }
            }

            return Column(
              children: [
                ChattingCard(
                  id: chats[index].id,
                  senderId: chats[index].senderId,
                  senderName: chats[index].sender,
                  message: chats[index].message,
                  partyId: chats[index].partyId,
                  time: time,
                  imageUrl: chats[index].imageUrl,
                  isMine: user.id == chats[index].senderId,
                  showProfile: showProfile,
                ),
                SizedBox(height: 8),
              ],
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
// UserModel user = UserModel(
//   id: "cbPEwXPCa0z0ZL8T4q1N",
//   address: "경기도 의정부시",
//   name: "오상구",
//   img: "https://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg",
// );
