class Party {
  final String partyName;
  final String address;
  final String content;

  Party({
    required this.partyName,
    required this.address,
    required this.content,
  });

  Party.fromJson(Map<String, dynamic> json)
      : this(
            partyName: json["partyName"] ?? "",
            address: json["address"] ?? "",
            content: json["content"] ?? "");

  Map<String, dynamic> toJson() => {
        "partyName": partyName,
        "address": address,
        "content": content,
      };
}
