class AppConstants {
  // Delivery fees by zone
  static const Map<String, int> deliveryFees = {
    'Urban': 20,
    'Suburban': 30,
    'Remote': 50,
  };

  // Promo codes
  static const Map<String, PromoCode> promoCodes = {
    'SAVE50': PromoCode(
      code: 'SAVE50',
      discount: 50,
      minOrder: 700,
      description: 'Get ₹50 off on orders above ₹700',
    ),
    'FIRST100': PromoCode(
      code: 'FIRST100',
      discount: 100,
      minOrder: 500,
      description: 'Get ₹100 off on your first order above ₹500',
      isFirstOrderOnly: true,
    ),
    'WELCOME20': PromoCode(
      code: 'WELCOME20',
      discount: 20,
      minOrder: 200,
      description: 'Get ₹20 off on orders above ₹200',
    ),
  };

  // Hive box names
  static const String restaurantsBox = 'restaurants';
  static const String cartBox = 'cart';
  static const String favoritesBox = 'favorites';
}

class PromoCode {
  final String code;
  final int discount;
  final int minOrder;
  final String description;
  final bool isFirstOrderOnly;

  const PromoCode({
    required this.code,
    required this.discount,
    required this.minOrder,
    required this.description,
    this.isFirstOrderOnly = false,
  });
}

