import 'package:flutter/foundation.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/services/cart_service.dart';
import '../../../data/services/delivery_fee_service.dart';
import '../../../data/services/promo_code_service.dart';
import '../../../core/constants/app_constants.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  String? _appliedPromoCode;
  PromoCode? _promoCode;
  final bool _isFirstOrder = true;

  List<CartItem> get cartItems => _cartItems;
  String? get appliedPromoCode => _appliedPromoCode;
  PromoCode? get promoCode => _promoCode;
  bool get isEmpty => _cartItems.isEmpty;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  int get subtotal => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  int get deliveryFee {
    if (_cartItems.isEmpty) return 0;
    // Get zone from first item's restaurant
    final zone = _cartItems.first.restaurantZone;
    return DeliveryFeeService.getDeliveryFee(zone);
  }

  String? get restaurantZone {
    if (_cartItems.isEmpty) return null;
    return _cartItems.first.restaurantZone;
  }

  int get discount {
    if (_promoCode == null) return 0;
    return PromoCodeService.calculateDiscount(_promoCode!, subtotal);
  }

  int get grandTotal {
    return subtotal + deliveryFee - discount;
  }

  Future<void> loadCart() async {
    _cartItems = await CartService.loadCart();
    notifyListeners();
  }

  Future<void> addItem(CartItem item) async {
    final existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.menuItemId == item.menuItemId,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }

    await CartService.saveCart(_cartItems);
    notifyListeners();
  }

  Future<void> removeItem(String menuItemId) async {
    _cartItems.removeWhere((item) => item.menuItemId == menuItemId);
    await CartService.saveCart(_cartItems);
    notifyListeners();
  }

  Future<void> updateQuantity(String menuItemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(menuItemId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.menuItemId == menuItemId);
    if (index >= 0) {
      _cartItems[index].quantity = quantity;
      await CartService.saveCart(_cartItems);
      notifyListeners();
    }
  }

  void applyPromoCode(String code) {
    final promo = PromoCodeService.validatePromoCode(
      code,
      subtotal,
      isFirstOrder: _isFirstOrder,
    );

    if (promo != null) {
      _appliedPromoCode = code.toUpperCase();
      _promoCode = promo;
      notifyListeners();
    } else {
      _appliedPromoCode = null;
      _promoCode = null;
      notifyListeners();
    }
  }

  void removePromoCode() {
    _appliedPromoCode = null;
    _promoCode = null;
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    _appliedPromoCode = null;
    _promoCode = null;
    await CartService.clearCart();
    notifyListeners();
  }

}

