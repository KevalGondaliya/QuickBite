import 'package:flutter/foundation.dart';
import '../../../data/models/restaurant.dart';
import '../../../data/services/restaurant_service.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];
  bool _isLoading = false;
  bool _isOffline = false;
  String _searchQuery = '';
  String _sortBy = 'rating'; // 'rating', 'name'
  final Set<String> _favorites = {};

  List<Restaurant> get restaurants => _filteredRestaurants;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;
  String get searchQuery => _searchQuery;
  String get sortBy => _sortBy;
  Set<String> get favorites => _favorites;

  bool isFavorite(String restaurantId) {
    return _favorites.contains(restaurantId);
  }

  void toggleFavorite(String restaurantId) {
    if (_favorites.contains(restaurantId)) {
      _favorites.remove(restaurantId);
    } else {
      _favorites.add(restaurantId);
    }
    notifyListeners();
  }

  Future<void> loadRestaurants() async {
    _isLoading = true;
    _isOffline = false;
    notifyListeners();

    try {
      _restaurants = await RestaurantService.loadRestaurants();
      _applyFilters();
    } catch (e) {
      // Try to load from cache
      _restaurants = await RestaurantService.getCachedRestaurants();
      _isOffline = _restaurants.isEmpty;
      _applyFilters();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredRestaurants = List.from(_restaurants);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredRestaurants = _filteredRestaurants.where((restaurant) {
        return restaurant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            restaurant.cuisine.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply sort
    if (_sortBy == 'rating') {
      _filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_sortBy == 'name') {
      _filteredRestaurants.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  Restaurant? getRestaurantById(String id) {
    try {
      return _restaurants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
}

