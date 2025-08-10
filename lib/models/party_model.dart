class Party {
  final String id;
  final String partyName;
  final String address;
  final String content;

  Party({
    required this.id,
    required this.partyName,
    required this.address,
    required this.content,
  });

  Party.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"] ?? "",
            partyName: json["partyName"] ?? "",
            address: json["address"] ?? "",
            content: json["content"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "partyName": partyName,
        "address": address,
        "content": content,
      };
}
