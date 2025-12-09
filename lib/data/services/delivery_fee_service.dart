import '../../core/constants/app_constants.dart';

class DeliveryFeeService {
  static int getDeliveryFee(String zone) {
    return AppConstants.deliveryFees[zone] ?? 0;
  }

  static Map<String, int> getAllDeliveryFees() {
    return AppConstants.deliveryFees;
  }
}

