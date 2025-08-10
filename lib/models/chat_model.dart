class Chat {
  String sender;
  String senderId;
  String partyName;
  String message;
  DateTime createdAt;
  String profileImgUrl;

  Chat({
    required this.sender, // 메세지 쓴 사람
    required this.senderId, // 메세지 쓴 사람 고유 ID -> 닉네임이 겹칠까봐?
    required this.partyName, // 모임 이름으로 고유 키 역할
    required this.message, // 메세지 내용
    required this.createdAt, // 메세지 작성 날짜 및 시간
    required this.profileImgUrl, // 메세지 쓴 사람 이미지
  });

  Chat.fromJson(Map<String, dynamic> map)
      : this(
          sender: map["sender"],
          senderId: map["senderId"],
          partyName: map["partyName"],
          message: map["message"],
          createdAt: map["createdAt"],
          profileImgUrl: map["profileImgUrl"],
        );

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "senderId": senderId,
      "partyName": partyName,
      "message": message,
      "createdAt": createdAt,
      "profileImgUrl": profileImgUrl,
    };
  }
}
