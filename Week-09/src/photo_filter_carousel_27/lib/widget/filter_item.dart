import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.color, this.onFilterSelected});

  final Color color;
  final VoidCallback? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Image.network(
              // Use a stable placeholder service. You can swap this for a
              // local asset later (recommended for production).
              'https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740&q=80',
              color: color.withOpacity(0.5),
              colorBlendMode: BlendMode.hardLight,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // If texture image fails, fall back to a solid circle using
                // the filter color so the UI remains usable.
                return Container(color: color);
              },
            ),
          ),
        ),
      ),
    );
  }
}
