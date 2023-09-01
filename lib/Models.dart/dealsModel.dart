// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class deals {
  String name;
  String image;
  num price;
    String cart;
    int? noOrders;
    String quantity;
  deals({
    required this.name,
    required this.image,
    required this.price,
    required this.cart,
    this.noOrders,
    required this.quantity,
  });
  

  deals copyWith({
    String? name,
    String? image,
    num? price,
    String? cart,
    int? noOrders,
    String? quantity,
  }) {
    return deals(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      cart: cart ?? this.cart,
      noOrders: noOrders ?? this.noOrders,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'price': price,
      'cart': cart,
      'noOrders': noOrders,
      'quantity': quantity,
    };
  }

  factory deals.fromMap(Map<String, dynamic> map) {
    return deals(
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
      cart: map['cart'] as String,
      noOrders: map['noOrders'] != null ? map['noOrders'] as int : null,
      quantity: map['quantity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory deals.fromJson(String source) => deals.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'deals(name: $name, image: $image, price: $price, cart: $cart, noOrders: $noOrders, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant deals other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.image == image &&
      other.price == price &&
      other.cart == cart &&
      other.noOrders == noOrders &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      cart.hashCode ^
      noOrders.hashCode ^
      quantity.hashCode;
  }
}
