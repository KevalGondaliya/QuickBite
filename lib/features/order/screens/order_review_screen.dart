import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../../data/models/restaurant.dart';
import '../../../core/utils/formatters.dart';

class OrderReviewScreen extends StatelessWidget {
  final Restaurant? restaurant;

  const OrderReviewScreen({
    super.key,
    this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Review'),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final cartItems = cartProvider.cartItems;
          final deliveryFee = cartProvider.deliveryFee;
          final subtotal = cartProvider.subtotal;
          final discount = cartProvider.discount;
          final grandTotal = subtotal + deliveryFee - discount;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Order Items
                    const Text(
                      'Order Items',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...cartItems.map((item) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(item.itemName),
                          subtitle: Text('Qty: ${item.quantity}'),
                          trailing: Text(
                            Formatters.formatCurrency(item.totalPrice),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    // Restaurant Info
                    if (cartItems.isNotEmpty) ...[
                      const Text(
                        'Restaurant Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems.first.restaurantName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Zone: ${cartItems.first.restaurantZone}'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
              // Order Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Items Total', subtotal),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Delivery Fee', deliveryFee),
                    if (discount > 0) ...[
                      const SizedBox(height: 8),
                      _buildSummaryRow(
                        'Discount (${cartProvider.appliedPromoCode})',
                        -discount,
                        isDiscount: true,
                      ),
                    ],
                    const Divider(height: 24),
                    _buildSummaryRow('Grand Total', grandTotal, isTotal: true),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showOrderPlacedDialog(context, cartProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String label, int amount, {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isDiscount ? Colors.green.shade700 : Colors.black87,
          ),
        ),
        Text(
          isDiscount ? '-${Formatters.formatCurrency(amount.abs())}' : Formatters.formatCurrency(amount),
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isDiscount ? Colors.green.shade700 : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showOrderPlacedDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 8),
            Text('Order Placed!'),
          ],
        ),
        content: const Text('Your order has been placed successfully. You will receive a confirmation shortly.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              cartProvider.clearCart();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Back to Restaurants'),
          ),
        ],
      ),
    );
  }
}

