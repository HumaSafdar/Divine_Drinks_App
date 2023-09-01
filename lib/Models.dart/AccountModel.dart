// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountModel {
  String email;
  String password;
  String phone;
  String username;
  AccountModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.username,
  });
  

  AccountModel copyWith({
    String? email,
    String? password,
    String? phone,
    String? username,
  }) {
    return AccountModel(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'phone': phone,
      'username': username,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) => AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountModel(email: $email, password: $password, phone: $phone, username: $username)';
  }

  @override
  bool operator ==(covariant AccountModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.phone == phone &&
      other.username == username;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      username.hashCode;
  }
}
