// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class userdetail {
  String password;
  String firstname;
  String lastName;
  String phoneNumber;
  userdetail({
    required this.password,
    required this.firstname,
    required this.lastName,
    required this.phoneNumber,
  });
  

  userdetail copyWith({
    String? password,
    String? firstname,
    String? lastName,
    String? phoneNumber,
  }) {
    return userdetail(
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'firstname': firstname,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  factory userdetail.fromMap(Map<String, dynamic> map) {
    return userdetail(
      password: map['password'] as String,
      firstname: map['firstname'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory userdetail.fromJson(String source) => userdetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'userdetail(password: $password, firstname: $firstname, lastName: $lastName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant userdetail other) {
    if (identical(this, other)) return true;
  
    return 
      other.password == password &&
      other.firstname == firstname &&
      other.lastName == lastName &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return password.hashCode ^
      firstname.hashCode ^
      lastName.hashCode ^
      phoneNumber.hashCode;
  }
}
