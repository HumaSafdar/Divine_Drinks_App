// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class Appbarname {
 String id;
 String name;
  Appbarname({
    required this.id,
    required this.name,
  });
 

  Appbarname copyWith({
    String? id,
    String? name,
  }) {
    return Appbarname(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Appbarname.fromMap(Map<String, dynamic> map) {
    return Appbarname(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appbarname.fromJson(String source) => Appbarname.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Appbarname(id: $id, name: $name)';

  @override
  bool operator ==(covariant Appbarname other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
 }
