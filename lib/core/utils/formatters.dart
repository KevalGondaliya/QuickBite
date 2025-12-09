import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat currencyFormat = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 0,
  );

  static String formatCurrency(int amount) {
    return currencyFormat.format(amount);
  }
}

