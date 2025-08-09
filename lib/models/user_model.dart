// lib/models/user_model.dart

import 'dart:convert';

class UserModel {
  final String id; //식별키
  final String name; //사용자 이름
  final String address; // 주소
  final String? img; // 이미지 주소

  //생성자
  UserModel({
    required this.id,
    required this.name,
    required this.address,
    this.img,
  });

//빈사용자(기본값) 생성 핼퍼
  factory UserModel.empty() => UserModel(
        id: '',
        name: '',
        address: '',
        img: null,
      );

//원본은 유지하고 기존 객체에서 일부만 바꾼 새 객체 생성
  UserModel copyWith({
    String? id,
    String? name, //사용자 이름
    String? address, // 주소
    String? img,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      img: img ?? this.img,
    );
  }

//객체를 map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'img': img,
    };
  }

//Map 데이터를 UserModel객체로 복원
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      img: map['img'] == null ? null : map['img'] as String,
    );
  }

  //json을 UserModel로 변환
  String toJson() => json.encode(toMap());

  //fromJson
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  //디버깅 출력용
  @override
  String toString() =>
      'UserModel(id: $id, name: $name, address: $address, img: $img)';
}
