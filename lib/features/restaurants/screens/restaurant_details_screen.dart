import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/restaurant.dart';
import '../../../data/models/cart_item.dart';
import '../../cart/providers/cart_provider.dart';
import '../../cart/screens/cart_screen.dart';
import '../widgets/menu_item_card.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Restaurant Info Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade600,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        restaurant.cuisine,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Delivery Zone: ${restaurant.zone}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: restaurant.menu.length,
                  itemBuilder: (context, index) {
                    final menuItem = restaurant.menu[index];
                    // Find if this item is in cart
                    final cartItemIndex = cartProvider.cartItems.indexWhere(
                      (item) => item.menuItemId == menuItem.id,
                    );
                    final cartQuantity = cartItemIndex >= 0
                        ? cartProvider.cartItems[cartItemIndex].quantity
                        : 0;

                    return MenuItemCard(
                      menuItem: menuItem,
                      restaurantId: restaurant.id,
                      restaurantName: restaurant.name,
                      cartQuantity: cartQuantity,
                      onAddToCart: () {
                        final cartItem = CartItem.fromMenuItem(
                          menuItem: menuItem,
                          restaurantId: restaurant.id,
                          restaurantName: restaurant.name,
                          restaurantZone: restaurant.zone,
                        );
                        cartProvider.addItem(cartItem);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${menuItem.name} added to cart'),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      onIncrement: () {
                        cartProvider.updateQuantity(
                          menuItem.id,
                          cartQuantity + 1,
                        );
                      },
                      onDecrement: () {
                        cartProvider.updateQuantity(
                          menuItem.id,
                          cartQuantity - 1,
                        );
                      },
                      onRemove: () {
                        cartProvider.removeItem(menuItem.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${menuItem.name} removed from cart'),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      onCartBadgeTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CartScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

