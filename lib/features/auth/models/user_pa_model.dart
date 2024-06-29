// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserPaModel {
  final int id;
  final String pa;
  final String status;

  UserPaModel({required this.id, required this.pa, required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pa': pa,
      'status': status,
    };
  }

  factory UserPaModel.fromMap(Map<String, dynamic> map) {
    return UserPaModel(
      id: map['id'] as int,
      pa: map['pa'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPaModel.fromJson(String source) =>
      UserPaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
