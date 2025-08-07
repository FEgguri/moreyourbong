import 'package:flutter/material.dart';
import 'package:moreyourbong/views/widgets/custom_dialog.dart';

class PartyList extends StatefulWidget {
  const PartyList({super.key});

  @override
  State<PartyList> createState() => _PartyListState();
}

class _PartyListState extends State<PartyList> {
  @override
  Widget build(BuildContext context) {
    // 뒤로가기 팝업 필요 시 사용
    // PopScope(
    //   canPop: false,
    //   onPopInvoked: (didPop) async {
    //     await showCustomDialog(context);
    //   },

    // UI
    return LayoutBuilder(
      builder: (context, constraints) {
        // 아이템 크기 설정 및 계산
        final double spacing = 16;
        final int crossAxisCount = 2;
        final double totalSpacing = spacing * (crossAxisCount - 1);
        final double itemWidth =
            (constraints.maxWidth - totalSpacing) / crossAxisCount;
        final double itemHeight = itemWidth * 1.0;

        // 모임 리스트 UI
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1} 모임명',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'OO시 OO구 OO동 주소',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'OO 봉사 갈거고 여기는 단톡방~ 이렇게 긴 텍스트를 쓰면 이렇게',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      chatButton(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // 채팅 버튼
  Widget chatButton() {
    return GestureDetector(
      onTap: () {
        // 팝업창 및 채팅창 페이지 이동
        showCustomDialog(context);
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            "채팅",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
