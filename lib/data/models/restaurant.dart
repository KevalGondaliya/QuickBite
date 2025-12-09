class Restaurant {
  final String id;
  final String name;
  final String zone;
  final double rating;
  final String cuisine;
  final List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.zone,
    required this.rating,
    required this.cuisine,
    required this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      zone: json['zone'] as String,
      rating: (json['rating'] as num).toDouble(),
      cuisine: json['cuisine'] as String,
      menu: (json['menu'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'zone': zone,
      'rating': rating,
      'cuisine': cuisine,
      'menu': menu.map((item) => item.toJson()).toList(),
    };
  }
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final int price;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}

