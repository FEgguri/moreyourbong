import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // String message = "안녕하세요";
    String message = "안녕하세요 이 글은 장문의 글이라서 잘릴 수도 있어요 근데 제가 잘 설정 해놔서 4줄을 넘어가게 되면 ...으로 표시된답니다 ㅎ하하하하하하하하ㅏ하하하하하하하ㅏ하하하하하하하ㅏ";
    String time = "오후 2:31";
    int bottomSheetHeight = 100;
    return Scaffold(
      backgroundColor: Color(0xFFFFCA28),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "모임 이름",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // TODO 말풍선의 내용이 짧아지면 옆에 빈공간이 생김 어떻게 해결하지..?
      body: ListView.separated(
          padding: EdgeInsets.fromLTRB(12, 20, 12, bottomSheetHeight + 10),
          itemCount: 10,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            if (index == 0) {
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            constraints: BoxConstraints(maxWidth: 250),
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              message,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
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
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    constraints: BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      message,
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }
          }),
      bottomSheet: SafeArea(
        child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }
}
