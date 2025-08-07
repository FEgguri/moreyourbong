import 'dart:math';

import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // String message = "안녕하세요";
    String message = "안녕하세요 이 글은 장문의 글이라서 잘릴 수도 있어요 근데 제가 잘 설정 해놔서 4줄을 넘어가게 되면 ...으로 표시된답니다 ㅎ하하하하하하하하ㅏ하하하하하하하ㅏ하하하하하하하ㅏ";
    String time = "오후 2:31";
    double bottomSheetHeight = 100;
    // Color(0xFFFFCA28)
    // Color(0xFF)
    return GestureDetector(
      // behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Color(0xFFFFCA28),
          centerTitle: true,
          title: Text(
            "모임 이름",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
            padding: EdgeInsets.fromLTRB(12, 20, 12, bottomSheetHeight + 10),
            itemCount: 7,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              if (index == 0 || index == 2 || index == 3 || index == 6) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          "https://picsum.photos/200/300",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "오상구",
                          style: TextStyle(
                            color: Color(0xff343434),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              constraints: BoxConstraints(maxWidth: 250),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // color: Color(0xffFFCA28),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                message,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(color: Color(0xFF343434)),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF888888),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        print("message tap");
                        FocusScope.of(context).unfocus();
                      },
                      onLongPress: () {
                        print("message long press");
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        constraints: BoxConstraints(maxWidth: 250),
                        decoration: BoxDecoration(
                          color: Color(0xff4CAF50),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          message,
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
        bottomSheet: SafeArea(
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
