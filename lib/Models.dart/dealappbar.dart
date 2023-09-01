// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class dealAppbar {
  String name;
  dealAppbar({
    required this.name,
  });
  

  dealAppbar copyWith({
    String? name,
  }) {
    return dealAppbar(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory dealAppbar.fromMap(Map<String, dynamic> map) {
    return dealAppbar(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory dealAppbar.fromJson(String source) => dealAppbar.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'dealAppbar(name: $name)';

  @override
  bool operator ==(covariant dealAppbar other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
