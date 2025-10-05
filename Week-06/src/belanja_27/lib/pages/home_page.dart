import 'package:flutter/material.dart';
import 'package:belanja_27/models/item.dart';
import 'package:belanja_27/widgets/my_search_bar.dart';
import 'package:belanja_27/widgets/my_category_chips.dart';
import 'package:belanja_27/widgets/pet_card_widget.dart';
import 'package:belanja_27/widgets/app_footer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  HomePage({super.key});

  final List<Item> items = [
    const Item(
      name: 'Mimi',
      species: 'Cat',
      breed: 'Domestic',
      ageMonths: 12,
      location: 'Jakarta Barat',
      price: 70000,
      photo: 'assets/images/cat.jpg',
      photos: ['assets/images/cat.jpg', 'assets/images/cat2.jpg'],
      vaccinated: true,
      gender: 'Female',
      rating: 4.4,
      description: 'Playful and healthy domestic cat. Loves attention.',
    ),
    const Item(
      name: 'Kapibara',
      species: 'Rodent',
      breed: 'Capybara',
      ageMonths: 24,
      location: 'Bogor',
      price: 250000,
      photo: 'assets/images/kapibara.jpg',
      photos: ['assets/images/kapibara.jpg'],
      vaccinated: true,
      gender: 'Male',
      rating: 4.9,
      description:
          'Gentle giant, loves water and socializing. Perfect for exotic pet lovers.',
    ),
    const Item(
      name: 'Hammy',
      species: 'Rodent',
      breed: 'Hamster',
      ageMonths: 5,
      location: 'Bandung',
      price: 45000,
      photo: 'assets/images/hamster.jpg',
      photos: ['assets/images/hamster.jpg'],
      vaccinated: false,
      gender: 'Male',
      rating: 4.1,
      description: 'Cute and active hamster. Easy to care for.',
    ),
    const Item(
      name: 'Rio',
      species: 'Bird',
      breed: 'Macaw',
      ageMonths: 18,
      location: 'Bali',
      price: 750000,
      photo: 'assets/images/macaw.jpg',
      photos: ['assets/images/macaw.jpg'],
      vaccinated: true,
      gender: 'Male',
      rating: 4.8,
      description:
          'Colorful and intelligent macaw. Loves to interact and mimic sounds.',
    ),
    const Item(
      name: 'Kana Kobayashi',
      species: 'Dragon',
      breed: 'Loli',
      ageMonths: 120,
      location: 'Kobayashi Residence',
      price: 999999,
      photo: 'assets/images/loli.jpg',
      photos: ['assets/images/loli.jpg'],
      vaccinated: true,
      gender: 'Female',
      rating: 5.0,
      description:
          'Cute, energetic, loves sweets and friends. From Miss Kobayashi\'s Dragon Maid.',
    ),
    const Item(
      name: 'Teman Nongkrong',
      species: 'Human',
      breed: 'Slave',
      ageMonths: 240,
      location: 'Unknown',
      price: 1000,
      photo: 'assets/images/slave.jpg',
      photos: ['assets/images/slave.jpg'],
      vaccinated: false,
      gender: 'Male',
      rating: 1.0,
      description: 'Orang jomok, dijual murah. Tidak divaksin.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final paletteMain = const Color(0xFF2E7D32); // green

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: paletteMain,
        elevation: 0,
        title: const Text('Pet Marketplace'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: const MySearchBar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const MyCategoryChips(),
            ),

            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final pet = items[index];
                    return PetCardWidget(pet: pet, primary: paletteMain);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            const AppFooter(name: 'Taufik Dimas', nim: '2341720062'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: paletteMain,
        child: const Icon(Icons.add),
      ),
    );
  }

  // helper methods removed; using modular widgets instead
}
