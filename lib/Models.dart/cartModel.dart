// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class cartModel {
  String image;
  String name;
  num price;
  num originalprice;
  String quantity;

 

  int noOrders;
  cartModel({
    required this.image,
    required this.name,
    required this.price,
    required this.originalprice,
    required this.quantity,
    required this.noOrders,
  });
 

  cartModel copyWith({
    String? image,
    String? name,
    num? price,
    num? originalprice,
    String? quantity,
    int? noOrders,
  }) {
    return cartModel(
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      originalprice: originalprice ?? this.originalprice,
      quantity: quantity ?? this.quantity,
      noOrders: noOrders ?? this.noOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'price': price,
      'originalprice': originalprice,
      'quantity': quantity,
      'noOrders': noOrders,
    };
  }

  factory cartModel.fromMap(Map<String, dynamic> map) {
    return cartModel(
      image: map['image'] as String,
      name: map['name'] as String,
      price: map['price'] as num,
      originalprice: map['originalprice'] as num,
      quantity: map['quantity'] as String,
      noOrders: map['noOrders'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory cartModel.fromJson(String source) => cartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'cartModel(image: $image, name: $name, price: $price, originalprice: $originalprice, quantity: $quantity, noOrders: $noOrders)';
  }

  @override
  bool operator ==(covariant cartModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.name == name &&
      other.price == price &&
      other.originalprice == originalprice &&
      other.quantity == quantity &&
      other.noOrders == noOrders;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      name.hashCode ^
      price.hashCode ^
      originalprice.hashCode ^
      quantity.hashCode ^
      noOrders.hashCode;
  }
}
