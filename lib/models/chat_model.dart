// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chat {
  String sender;
  String senderId;
  String address;
  String message;
  DateTime createdAt;
  String profileImgUrl;

  Chat({
    required this.sender,
    required this.senderId,
    required this.address,
    required this.message,
    required this.createdAt,
    required this.profileImgUrl,
  });

  Chat.fromJson(Map<String, dynamic> map)
      : this(
          sender: map["sender"],
          senderId: map["senderId"],
          address: map["address"],
          message: map["message"],
          createdAt: map["createdAt"],
          profileImgUrl: map["profileImgUrl"],
        );

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "senderId": senderId,
      "address": address,
      "message": message,
      "createdAt": createdAt,
      "profileImgUrl": profileImgUrl,
    };
  }
}
