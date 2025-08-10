// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChattingCard extends StatelessWidget {
  String message;
  String time;
  String imageUrl;
  bool isMine;

  ChattingCard({
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    return isMine
        ? Row(
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
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                // child: Image.network(
                //   "https://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg",
                //   fit: BoxFit.cover,
                // ),
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
                        time.toString(),
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
  }
}

String message = "안녕하세요 이 글은 장문의 글이라서 잘릴 수도 있어요 근데 제가 잘 설정 해놔서 4줄을 넘어가게 되면 ...으로 표시된답니다 ㅎ하하하하하하하하ㅏ하하하하하하하ㅏ하하하하하하하ㅏ";
String time = "오후 2:31";

List<ChattingCard> tempDataList = [
  ChattingCard(message: message, time: time, imageUrl: "", isMine: false),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: false),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: true),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: false),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: true),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: true),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: false),
  ChattingCard(message: message, time: time, imageUrl: "", isMine: true),
];
