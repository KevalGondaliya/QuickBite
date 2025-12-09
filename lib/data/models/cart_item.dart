import '../models/restaurant.dart';

class CartItem {
  final String menuItemId;
  final String restaurantId;
  final String restaurantName;
  final String restaurantZone;
  final String itemName;
  final String itemDescription;
  final int price;
  int quantity;

  CartItem({
    required this.menuItemId,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantZone,
    required this.itemName,
    required this.itemDescription,
    required this.price,
    this.quantity = 1,
  });

  int get totalPrice => price * quantity;

  factory CartItem.fromMenuItem({
    required MenuItem menuItem,
    required String restaurantId,
    required String restaurantName,
    required String restaurantZone,
    int quantity = 1,
  }) {
    return CartItem(
      menuItemId: menuItem.id,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      restaurantZone: restaurantZone,
      itemName: menuItem.name,
      itemDescription: menuItem.description,
      price: menuItem.price,
      quantity: quantity,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menuItemId: json['menuItemId'] as String,
      restaurantId: json['restaurantId'] as String,
      restaurantName: json['restaurantName'] as String,
      restaurantZone: json['restaurantZone'] as String? ?? 'Urban',
      itemName: json['itemName'] as String,
      itemDescription: json['itemDescription'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantZone': restaurantZone,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'price': price,
      'quantity': quantity,
    };
  }

  CartItem copyWith({
    String? menuItemId,
    String? restaurantId,
    String? restaurantName,
    String? restaurantZone,
    String? itemName,
    String? itemDescription,
    int? price,
    int? quantity,
  }) {
    return CartItem(
      menuItemId: menuItemId ?? this.menuItemId,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantZone: restaurantZone ?? this.restaurantZone,
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

