import '../../core/constants/app_constants.dart';

class PromoCodeService {
  static PromoCode? validatePromoCode(String code, int orderTotal, {bool isFirstOrder = false}) {
    final promoCode = AppConstants.promoCodes[code.toUpperCase()];
    
    if (promoCode == null) {
      return null;
    }

    if (promoCode.isFirstOrderOnly && !isFirstOrder) {
      return null;
    }

    if (orderTotal < promoCode.minOrder) {
      return null;
    }

    return promoCode;
  }

  static int calculateDiscount(PromoCode promoCode, int orderTotal) {
    return promoCode.discount;
  }
}

