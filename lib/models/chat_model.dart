class Chat {
  String id;
  String sender;
  String senderId;
  String partyName;
  String message;
  String partyId;
  DateTime createdAt;
  String? imageUrl;

  Chat({
    required this.id,
    required this.sender, // 메세지 쓴 사람
    required this.senderId, // 메세지 쓴 사람 고유 ID -> 닉네임이 겹칠까봐?
    required this.partyName, // 모임 이름으로 고유 키 역할
    required this.message, // 메세지 내용
    required this.partyId, // 메세지 작성 날짜 및 시간
    required this.createdAt, // 메세지 작성 날짜 및 시간
    required this.imageUrl, // 메세지 쓴 사람 이미지
  });

  Chat.fromJson(Map<String, dynamic> map)
      : this(
          id: map["id"] ?? "",
          sender: map["sender"] ?? "",
          senderId: map["senderId"] ?? "",
          partyName: map["partyName"] ?? "",
          message: map["message"] ?? "",
          partyId: map["partyId"] ?? "",
          createdAt: DateTime.parse(map["createdAt"] ?? ""),
          imageUrl: map["imageUrl"] ?? "",
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sender": sender,
      "senderId": senderId,
      "partyName": partyName,
      "message": message,
      "partyId": partyId,
      "createdAt": createdAt.toIso8601String(),
      "imageUrl": imageUrl,
    };
  }
}
