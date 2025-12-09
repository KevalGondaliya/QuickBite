import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import 'restaurant_details_screen.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/sort_dialog.dart';
import '../../../shared/widgets/fade_in_widget.dart';

class RestaurantsListScreen extends StatefulWidget {
  const RestaurantsListScreen({super.key});

  @override
  State<RestaurantsListScreen> createState() => _RestaurantsListScreenState();
}

class _RestaurantsListScreenState extends State<RestaurantsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantProvider>().loadRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBite'),
        elevation: 0,
        actions: [
          Consumer<RestaurantProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () => _showSortDialog(context, provider),
              );
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              if (provider.isOffline)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.orange.shade100,
                  child: Row(
                    children: [
                      Icon(Icons.wifi_off, color: Colors.orange.shade900),
                      const SizedBox(width: 8),
                      Text(
                        'Offline Mode - Showing cached data',
                        style: TextStyle(color: Colors.orange.shade900),
                      ),
                    ],
                  ),
                ),
              SearchBarWidget(
                onSearchChanged: (query) {
                  provider.setSearchQuery(query);
                },
              ),
              Expanded(
                child: provider.restaurants.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restaurant,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No restaurants found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: provider.restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = provider.restaurants[index];
                          return FadeInWidget(
                            delay: index * 100,
                            child: RestaurantCard(
                              restaurant: restaurant,
                              isFavorite: provider.isFavorite(restaurant.id),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RestaurantDetailsScreen(
                                      restaurant: restaurant,
                                    ),
                                  ),
                                );
                              },
                              onFavoriteTap: () {
                                provider.toggleFavorite(restaurant.id);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSortDialog(BuildContext context, RestaurantProvider provider) {
    showDialog(
      context: context,
      builder: (context) => SortDialog(
        currentSort: provider.sortBy,
        onSortSelected: (sortBy) {
          provider.setSortBy(sortBy);
          Navigator.pop(context);
        },
      ),
    );
  }
}

