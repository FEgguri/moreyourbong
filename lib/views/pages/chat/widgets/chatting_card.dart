// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChattingCard extends StatelessWidget {
  String message;
  String time;
  String? imageUrl;
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
                  child: imageUrl == null
                      ? Icon(
                          Icons.person,
                          size: 30,
                        )
                      : imageUrl!.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 30,
                            )
                          : Image.network(
                              imageUrl!,
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
