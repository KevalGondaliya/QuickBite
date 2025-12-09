# QuickBite Setup Guide

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions (optional)

## Installation Steps

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   ```bash
   flutter run
   ```

   Or use your IDE's run button.

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── constants/                     # App constants (delivery fees, promo codes)
│   ├── theme/                         # Theme configuration
│   └── utils/                         # Utility functions (formatters)
├── data/
│   ├── models/                        # Data models (Restaurant, MenuItem, CartItem)
│   ├── repositories/                  # Data repositories
│   └── services/                      # Business logic services
├── features/
│   ├── restaurants/                   # Restaurant feature
│   │   ├── screens/                   # Restaurant screens
│   │   ├── widgets/                   # Restaurant widgets
│   │   └── providers/                 # Restaurant state management
│   ├── cart/                          # Cart feature
│   │   ├── screens/                   # Cart screens
│   │   ├── widgets/                   # Cart widgets
│   │   └── providers/                 # Cart state management
│   └── order/                         # Order feature
│       ├── screens/                   # Order screens
│       └── widgets/                   # Order widgets
└── shared/
    └── widgets/                       # Shared reusable widgets
```

## Key Features Implemented

### ✅ Core Features
- Restaurants List with search and sort
- Restaurant Details with menu items
- Shopping Cart with quantity controls
- Order Review with totals and delivery fees
- Offline caching with Hive
- Promo code system

### ✅ Bonus Features
- Smooth fade-in animations
- Favorite restaurants (in-memory)
- Cart badge with item count
- Offline mode indicator
- Clean, modern UI

## Testing the App

1. **Browse Restaurants**: Navigate through the restaurant list
2. **Search**: Use the search bar to filter restaurants
3. **Sort**: Click the sort icon to sort by rating or name
4. **View Menu**: Tap a restaurant to see its menu
5. **Add to Cart**: Add items to your cart
6. **Manage Cart**: Adjust quantities or remove items
7. **Apply Promo**: Use promo codes like SAVE50, FIRST100, WELCOME20
8. **Place Order**: Review and place your order

## Promo Codes

- **SAVE50**: ₹50 off on orders above ₹700
- **FIRST100**: ₹100 off on first order above ₹500
- **WELCOME20**: ₹20 off on orders above ₹200

## Delivery Fees

- **Urban**: ₹20
- **Suburban**: ₹30
- **Remote**: ₹50

## Notes

- Data is loaded from `assets/data/restaurants.json`
- Cart persists using Hive local storage
- Favorites are stored in memory (not persisted)
- No payment integration (prototype only)

