import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/restaurant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';

class RestaurantService {
  static Future<List<Restaurant>> loadRestaurants() async {
    try {
      // Try to load from cache first
      final box = await Hive.openBox(AppConstants.restaurantsBox);
      final cachedData = box.get('restaurants_data');
      
      if (cachedData != null) {
        final List<dynamic> cachedList = jsonDecode(cachedData);
        return cachedList.map((json) => Restaurant.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading from cache: $e');
    }

    // Load from assets
    try {
      final String jsonString = await rootBundle.loadString('assets/data/restaurants.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> restaurantsJson = jsonData['restaurants'] as List;
      
      final restaurants = restaurantsJson
          .map((json) => Restaurant.fromJson(json))
          .toList();

      // Cache the data
      await _cacheRestaurants(restaurants);
      
      return restaurants;
    } catch (e) {
      print('Error loading restaurants: $e');
      rethrow;
    }
  }

  static Future<void> _cacheRestaurants(List<Restaurant> restaurants) async {
    try {
      final box = await Hive.openBox(AppConstants.restaurantsBox);
      final jsonList = restaurants.map((r) => r.toJson()).toList();
      await box.put('restaurants_data', jsonEncode(jsonList));
    } catch (e) {
      print('Error caching restaurants: $e');
    }
  }

  static Future<List<Restaurant>> getCachedRestaurants() async {
    try {
      final box = await Hive.openBox(AppConstants.restaurantsBox);
      final cachedData = box.get('restaurants_data');
      
      if (cachedData != null) {
        final List<dynamic> cachedList = jsonDecode(cachedData);
        return cachedList.map((json) => Restaurant.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading cached restaurants: $e');
    }
    return [];
  }
}

