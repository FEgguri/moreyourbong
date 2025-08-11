// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:moreyourbong/viewmodels/chat_view_model.dart';
import 'package:moreyourbong/views/pages/chat/chat_page.dart';

class ReviewOptionDialog extends StatelessWidget {
  ReviewOptionDialog({
    required this.partyId,
    required this.messageId,
    required this.senderId,
  });
  String partyId;
  String messageId;
  String senderId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getDialogOption(
                  title: "내 기기에서 삭제",
                  onTap: () {
                    Navigator.pop(context);
                    //
                  },
                ),
                if (senderId == user.id) ...[
                  Divider(height: 1),
                  Consumer(
                    builder: (context, ref, build) {
                      final viewModel = ref.read(chatViewModel(partyId).notifier);
                      return _getDialogOption(
                        title: "모든 대화 상대에게서 삭제",
                        onTap: () async {
                          await viewModel.deleteMessageFromAll(messageId).then((_) {
                            Navigator.pop(context);
                          });
                          //
                        },
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _getDialogOption({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 24, height: 2),
            ),
          ],
        ),
      ),
    );
  }
}
