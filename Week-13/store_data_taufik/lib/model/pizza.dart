// ========================
// PRAKTIKUM 1: Model Pizza untuk JSON serialization/deserialization
// PRAKTIKUM 2: Handle kompatibilitas data JSON dengan null safety dan type casting
// ========================

class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Praktikum 1: Factory constructor untuk deserialization dari JSON (TANPA error handling)
  // Praktikum 2: BELUM diterapkan - akan error jika data tidak konsisten
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      pizzaName: json['pizzaName']?.toString() ?? 'No name',
      description: json['description']?.toString() ?? '',
      price: json['price'] is double
          ? json['price']
          : double.parse(json['price'].toString()),
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  // Praktikum 1: Method untuk serialization ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
