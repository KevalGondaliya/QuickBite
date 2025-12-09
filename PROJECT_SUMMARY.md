# QuickBite Project Summary

## Overview
QuickBite is a Flutter prototype for a restaurant browsing and ordering application. The app demonstrates clean architecture, proper state management, offline caching, and a polished user experience.

## Architecture Decisions

### State Management: Provider
**Why Provider?**
- Simple and lightweight
- Easy to understand and maintain
- Well-documented and widely used in Flutter community
- Perfect for this prototype scope
- Less boilerplate compared to Bloc
- Built-in with Flutter (no additional setup needed)

### Offline Caching: Hive
**Why Hive?**
- Fast and lightweight NoSQL database
- Type-safe with code generation support
- Easy to use and maintain
- Perfect for caching restaurant data
- Persists data across app restarts
- Better performance than SharedPreferences for complex data

### Folder Structure: Feature-Based
**Why Feature-Based?**
- Clear separation of concerns
- Easy to navigate and maintain
- Scalable for future features
- Each feature is self-contained
- Follows Flutter best practices

## Key Components

### Models (`data/models/`)
- **Restaurant**: Represents restaurant data with menu items
- **MenuItem**: Represents individual menu items
- **CartItem**: Represents items in the cart with quantity

### Services (`data/services/`)
- **RestaurantService**: Handles loading and caching restaurant data
- **CartService**: Manages cart persistence
- **DeliveryFeeService**: Calculates delivery fees based on zones
- **PromoCodeService**: Validates and applies promo codes

### Providers (`features/*/providers/`)
- **RestaurantProvider**: Manages restaurant list state, search, sort, favorites
- **CartProvider**: Manages cart state, quantities, totals, promo codes

### Screens (`features/*/screens/`)
- **RestaurantsListScreen**: Browse and search restaurants
- **RestaurantDetailsScreen**: View menu and add items
- **CartScreen**: Manage cart items and apply promo codes
- **OrderReviewScreen**: Review and place order

## Delivery Fee Calculation

Delivery fees are calculated using a zone-to-fee mapping:

```dart
static const Map<String, int> deliveryFees = {
  'Urban': 20,
  'Suburban': 30,
  'Remote': 50,
};
```

The fee is computed in `DeliveryFeeService.getDeliveryFee(zone)` and is automatically included in cart totals. The zone is stored with each cart item, ensuring accurate fee calculation.

## Promo Code System

Promo codes are stored as constants and validated based on:
- Code existence
- Minimum order amount
- First order status (for FIRST100)

Available codes:
- **SAVE50**: ₹50 off on orders ≥ ₹700
- **FIRST100**: ₹100 off on first order ≥ ₹500
- **WELCOME20**: ₹20 off on orders ≥ ₹200

## Offline Support

1. **Data Loading**: Restaurant data is loaded from `assets/data/restaurants.json`
2. **Caching**: Data is cached in Hive when first loaded
3. **Offline Mode**: If JSON fails to load, cached data is used
4. **UI Indicator**: Orange banner shows when in offline mode
5. **Cart Persistence**: Cart items persist across app restarts

## UI/UX Features

### Animations
- Fade-in animations for restaurant list items
- Scale animation on "Add to Cart" button
- Smooth transitions between screens

### User Experience
- Search functionality with real-time filtering
- Sort by rating or name
- Favorite restaurants (heart icon)
- Cart badge showing item count
- Promo code dialog with available codes
- Empty state messages
- Loading indicators

### Design
- Material Design 3
- Consistent card layouts
- Color-coded zones and cuisines
- Clear typography hierarchy
- Responsive layouts

## Code Quality

- ✅ No linter errors
- ✅ Clean, readable code
- ✅ Proper error handling
- ✅ Reusable widgets
- ✅ Separation of concerns
- ✅ Type-safe models
- ✅ Consistent naming conventions

