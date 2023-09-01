
import 'dart:convert';

class ItemDescriptionModel {
  String image;
  String id;
  String name;
  num     price;
  String cart;
  String description;
  String quantity;
  ItemDescriptionModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.cart,
    required this.description,
    required this.quantity,
  });
 

  ItemDescriptionModel copyWith({
    String? image,
    String? id,
    String? name,
    num? price,
    String? cart,
    String? description,
    String? quantity,
  }) {
    return ItemDescriptionModel(
      image: image ?? this.image,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      cart: cart ?? this.cart,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'id': id,
      'name': name,
      'price': price,
      'cart': cart,
      'description': description,
      'quantity': quantity,
    };
  }

  factory ItemDescriptionModel.fromMap(Map<String, dynamic> map) {
    return ItemDescriptionModel(
      image: map['image'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] ?? 0,
      cart: map['cart'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDescriptionModel.fromJson(String source) => ItemDescriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemDescriptionModel(image: $image, id: $id, name: $name, price: $price, cart: $cart, description: $description, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant ItemDescriptionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.cart == cart &&
      other.description == description &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      cart.hashCode ^
      description.hashCode ^
      quantity.hashCode;
  }
}
