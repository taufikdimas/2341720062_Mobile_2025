import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
    this.imagePath,
  });

  final Color color;
  final VoidCallback? onFilterSelected;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    Widget childImage;

    if (imagePath != null) {
      try {
        final file = File(imagePath!);
        if (file.existsSync()) {
          childImage = Image.file(
            file,
            color: color.withOpacity(0.5),
            colorBlendMode: BlendMode.hardLight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: color),
          );
        } else {
          childImage = _networkFallback(color);
        }
      } catch (_) {
        childImage = _networkFallback(color);
      }
    } else {
      childImage = _networkFallback(color);
    }

    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(child: childImage),
        ),
      ),
    );
  }

  Widget _networkFallback(Color color) {
    return Image.network(
      'https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740&q=80',
      color: color.withOpacity(0.5),
      colorBlendMode: BlendMode.hardLight,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(color: color);
      },
    );
  }
}
