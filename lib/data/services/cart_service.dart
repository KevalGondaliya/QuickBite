import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart';
import '../../core/constants/app_constants.dart';

class CartService {
  static Future<void> saveCart(List<CartItem> cartItems) async {
    try {
      final box = await Hive.openBox(AppConstants.cartBox);
      final jsonList = cartItems.map((item) => item.toJson()).toList();
      await box.put('cart_items', jsonEncode(jsonList));
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  static Future<List<CartItem>> loadCart() async {
    try {
      final box = await Hive.openBox(AppConstants.cartBox);
      final cartData = box.get('cart_items');
      
      if (cartData != null) {
        List<dynamic> cartList;
        
        // Handle both old format (List) and new format (JSON string)
        if (cartData is String) {
          // New format: JSON string
          cartList = jsonDecode(cartData);
        } else if (cartData is List) {
          // Old format: List directly stored
          cartList = cartData;
        } else {
          return [];
        }
        
        return cartList
            .map((json) {
              // Convert Map<dynamic, dynamic> to Map<String, dynamic>
              if (json is Map) {
                final Map<String, dynamic> convertedJson = 
                    json.map((key, value) => MapEntry(key.toString(), value));
                return CartItem.fromJson(convertedJson);
              }
              return null;
            })
            .whereType<CartItem>()
            .toList();
      }
    } catch (e) {
      print('Error loading cart: $e');
      // If there's an error, clear the corrupted data
      try {
        final box = await Hive.openBox(AppConstants.cartBox);
        await box.delete('cart_items');
      } catch (_) {
        // Ignore cleanup errors
      }
    }
    return [];
  }

  static Future<void> clearCart() async {
    try {
      final box = await Hive.openBox(AppConstants.cartBox);
      await box.delete('cart_items');
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}

