import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/viewmodels/party_view_medel.dart';
import 'package:moreyourbong/views/pages/party_list/widgets/custom_dialog.dart';
import 'package:moreyourbong/views/pages/party_list/widgets/party_detail_dialog.dart';

class PartyList extends ConsumerStatefulWidget {
  final String selectedAddress;
  PartyList({super.key, required this.selectedAddress});

  @override
  ConsumerState<PartyList> createState() => _PartyListState();
}

class _PartyListState extends ConsumerState<PartyList> {
  @override
  Widget build(BuildContext context) {
    // party
    final party = ref.watch(partyViewModelProvider(widget.selectedAddress));

    // UI
    return party.when(
      data: (list) => list.isEmpty
          ?
          // 해당 지역에 모임이 없을 때
          Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "해당 지역에 모임이 없습니다.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "지금 바로 모임을 생성해보세요!",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 52)
                ],
              ),
            )

          // 해당 지역에 모임이 있을 때 리스트 출력
          : LayoutBuilder(
              builder: (context, constraints) {
                // 뒤로가기 팝업 필요 시 사용
                // PopScope(canPop: false,onPopInvoked: (didPop) async {await showCustomDialog(context);},

                // 아이템 크기 설정 및 계산
                final double spacing = 16;
                final int crossAxisCount = 2;
                final double totalSpacing = spacing * (crossAxisCount - 1);
                final double itemWidth =
                    (constraints.maxWidth - totalSpacing) / crossAxisCount;
                final double itemHeight = itemWidth * 1.0;

                // 모임 리스트 UI
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.builder(
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemBuilder: (context, index) {
                      final partyItem = list[index];

                      return GestureDetector(
                        onTap: () {
                          showPartyDetail(context, partyItem);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index].partyName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  list[index].address,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  list[index].content,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                chatButton(list[index]),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

      // 오류 발생 시
      error: (error, stackTrace) => Center(
        child: Text("오류가 발생하였습니다."),
      ),

      // 로딩 시
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // 채팅 버튼
  Widget chatButton(Party party) {
    return GestureDetector(
      onTap: () {
        // 팝업창 및 채팅창 페이지 이동
        showCustomDialog(context, party);
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
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
