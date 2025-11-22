// ========================
// PRAKTIKUM 1: Model Pizza untuk JSON serialization/deserialization
// PRAKTIKUM 2: Handle kompatibilitas data JSON dengan null safety dan type casting
// PRAKTIKUM 3: Menangani error JSON dengan konstanta
// ========================

// Praktikum 3 - Langkah 1: Deklarasi konstanta untuk kunci JSON
// Menghindari typo dan membuat kode lebih maintainable
const String keyId = 'id';
const String keyName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImage = 'imageUrl';

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

  // Praktikum 1: Factory constructor untuk deserialization dari JSON
  // Praktikum 2: Handle kompatibilitas data dengan tryParse dan null coalescing
  // Praktikum 3 - Langkah 2: Menggunakan konstanta untuk kunci JSON
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      // Praktikum 2: Handle String to Int conversion dengan parse
      id: json[keyId] is int ? json[keyId] : int.parse(json[keyId].toString()),

      // Praktikum 2: Handle null dengan default value 'No name'
      pizzaName: json[keyName]?.toString() ?? 'No name',

      // Praktikum 2: Handle null dengan string kosong
      description: json[keyDescription]?.toString() ?? '',

      // Praktikum 2: Handle String to Double conversion
      price: json[keyPrice] is double
          ? json[keyPrice]
          : double.parse(json[keyPrice].toString()),

      // Praktikum 2: Handle null imageUrl
      imageUrl: json[keyImage]?.toString() ?? '',
    );
  }

  // Praktikum 1: Method untuk serialization ke JSON
  // Praktikum 3 - Langkah 3: Menggunakan konstanta untuk kunci JSON
  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}
