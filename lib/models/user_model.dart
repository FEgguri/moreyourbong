import 'dart:convert';

class UserModel {
  final String id; // 문서 id (필수)
  final String name; // 사용자 이름
  final String address; // 주소 (예: "서울 강남구")
  final String? img; // 프로필 이미지 URL

  UserModel({
    required this.id,
    required this.name,
    required this.address,
    this.img,
  });

  factory UserModel.empty() =>
      UserModel(id: '', name: '', address: '', img: null);

  UserModel copyWith({
    String? id,
    String? name,
    String? address,
    String? img,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'img': img,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      img: map['img'] == null ? null : map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, address: $address, img: $img)';
}
