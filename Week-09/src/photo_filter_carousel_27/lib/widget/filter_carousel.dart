import 'dart:io';

import 'package:flutter/material.dart';

import 'filter_selector.dart';

@immutable
class PhotoFilterCarousel extends StatefulWidget {
  const PhotoFilterCarousel({super.key, this.imagePath});

  final String? imagePath;

  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}

class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    ),
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(child: _buildPhotoWithFilter()),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        // Jika path file lokal tersedia, gunakan Image.file.
        if (widget.imagePath != null) {
          try {
            final file = File(widget.imagePath!);
            if (file.existsSync()) {
              return Image.file(
                file,
                color: color.withOpacity(0.5),
                colorBlendMode: BlendMode.color,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[900]);
                },
              );
            }
          } catch (_) {
            // Silently fallthrough ke network placeholder
          }
        }

        // Fallback ke network image saat file lokal tidak tersedia.
        return Image.network(
          'https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740&q=80',
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Graceful fallback bila network image gagal dimuat.
            return Container(color: Colors.grey[900]);
          },
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
      imagePath: widget.imagePath,
    );
  }
}
