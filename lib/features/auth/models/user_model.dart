// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String pa;
  final String phoneNumber;
  final String? email;
  final String password;
  final bool confirmPassword;

  UserModel({
    required this.pa,
    required this.phoneNumber,
    this.email,
    required this.password,
    this.confirmPassword = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pa': pa,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pa: map['pa'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
