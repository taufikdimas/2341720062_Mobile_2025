import 'package:flutter/material.dart';

class MyCategoryChips extends StatelessWidget {
  final List<String> categories;
  const MyCategoryChips({super.key, this.categories = const ['All', 'Dogs', 'Cats', 'Birds', 'Small Pets', 'Aquatic']});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ChoiceChip(
            label: Text(categories[index]),
            selected: index == 0,
            onSelected: (_) {},
            selectedColor: Colors.green[100],
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}
