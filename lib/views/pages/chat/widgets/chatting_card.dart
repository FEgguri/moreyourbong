// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChattingCard extends StatelessWidget {
  String name;
  String message;
  String time;
  String? imageUrl;
  bool isMine;

  ChattingCard({
    required this.name,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat("yyyy/MM/dd", "ko_KR").format(DateTime.parse(time)),
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                  Text(
                    DateFormat("a hh:mm", "ko_KR").format(DateTime.parse(time)),
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4),
              GestureDetector(
                onLongPress: () {
                  print("message long press");
                  FocusScope.of(context).unfocus();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container();
                    },
                  );
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
                    name,
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat("yyyy/MM/dd", "ko_KR").format(DateTime.parse(time)),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF888888),
                            ),
                          ),
                          Text(
                            DateFormat("a hh:mm", "ko_KR").format(DateTime.parse(time)),
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
              ),
            ],
          );
  }
}
