class Item {
  // Pet marketplace model
  final String name; // pet name
  final String species; // e.g., Dog, Cat
  final String breed;
  final int ageMonths; // age in months
  final String location; // city or area
  final int price; // adoption fee
  final String? photo; // thumbnail
  final List<String> photos; // gallery
  final bool vaccinated;
  final String gender; // Male/Female/Unknown
  final double rating; // optional
  final String description;

  const Item({
    required this.name,
    required this.species,
    this.breed = '',
    this.ageMonths = 0,
    this.location = '',
    required this.price,
    this.photo,
    this.photos = const [],
    this.vaccinated = false,
    this.gender = 'Unknown',
    this.rating = 0.0,
    this.description = '',
  });
}
