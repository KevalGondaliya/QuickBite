# QuickBite Customer App 🍕

A Flutter prototype for a restaurant browsing and ordering application.

## 📱 Features

- **Restaurants List**: Browse available restaurants with ratings, cuisine types, and delivery zones
- **Restaurant Details**: View menu items with descriptions and prices
- **Shopping Cart**: Add items, adjust quantities, and view totals
- **Order Review**: Review order with itemized breakdown and delivery fees
- **Offline Support**: Cached data persists across app restarts
- **Promo Codes**: Apply discount codes for savings
- **Smooth Animations**: Polished UI with micro-interactions

## 🏗️ Architecture

### Folder Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── features/
│   ├── restaurants/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   ├── cart/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   └── order/
│       ├── screens/
│       └── widgets/
└── shared/
    └── widgets/
```

### State Management

**Provider** is used for state management because:
- Simple and lightweight
- Easy to understand and maintain
- Well-documented and widely used
- Perfect for this prototype scope
- No boilerplate compared to Bloc

### Key Components

1. **Models** (`data/models/`): Clean Dart classes representing data entities
2. **Services** (`data/services/`): Business logic and data operations
3. **Providers** (`features/*/providers/`): State management for each feature
4. **Screens** (`features/*/screens/`): UI screens organized by feature
5. **Widgets** (`features/*/widgets/`): Reusable UI components

### Offline Caching

**Hive** is used for local storage because:
- Fast and lightweight NoSQL database
- Type-safe with code generation
- Easy to use and maintain
- Perfect for caching restaurant data
- Persists data across app restarts

### Delivery Fee Calculation

Delivery fees are calculated based on the restaurant's delivery zone:

- **Urban**: ₹20
- **Suburban**: ₹30
- **Remote**: ₹50

The fee is computed in `DeliveryFeeService` using a zone-to-fee mapping. This service can be easily extended to support dynamic pricing or API-based fees in the future.

## 🚀 Getting Started

1. Install Flutter dependencies:
```bash
flutter pub get
```

2. Generate Hive adapters:
```bash
flutter pub run build_runner build
```

3. Run the app:
```bash
flutter run
```

## 📦 Dependencies

- **provider**: State management
- **hive**: Local database for caching
- **http**: API calls (for future use)
- **intl**: Internationalization and formatting

## 🎨 UI/UX Highlights

- Clean, modern Material Design
- Smooth animations and transitions
- Responsive layouts
- Search and filter functionality
- Favorite restaurants (in-memory)
- Promo code support
- Offline mode indicators

## 📝 Notes

- Data is loaded from `assets/data/restaurants.json`
- Cart state persists using Hive
- Promo codes are stored locally
- No payment integration (prototype only)

