import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:belanja_27/models/item.dart';

class PetCardWidget extends StatelessWidget {
  final Item pet;
  final Color primary;
  const PetCardWidget({super.key, required this.pet, required this.primary});

  @override
  Widget build(BuildContext context) {
    final displayImage =
        pet.photo ?? (pet.photos.isNotEmpty ? pet.photos[0] : null);
    final heroTag = displayImage ?? pet.name;

    return InkWell(
      onTap: () => GoRouter.of(context).push('/item', extra: pet),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: SizedBox(
                height: 120,
                width: double.infinity,
                child: displayImage != null
                    ? Hero(
                        tag: heroTag,
                        // custom flight shuttle to make the hero animation more interesting
                        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                          final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                          return AnimatedBuilder(
                            animation: curved,
                            builder: (context, child) {
                              final t = curved.value;
                              return Opacity(
                                opacity: lerpDouble(1.0, 0.98, t)!,
                                child: Transform.scale(
                                  scale: lerpDouble(1.0, 1.06, t)!,
                                    child: Material(
                                    color: Colors.transparent,
                                    elevation: lerpDouble(0, 12, t) ?? 0.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.lerp(BorderRadius.circular(14), BorderRadius.circular(22), t) ?? BorderRadius.circular(14),
                                      child: child,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Image.asset(
                              displayImage,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(color: Colors.grey[200]),
                            ),
                          );
                        },
                        child: Image.asset(
                          displayImage,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: Colors.grey[200]),
                        ),
                      )
                    : Container(color: Colors.grey[200]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pet.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: pet.vaccinated
                              ? Colors.green[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          pet.vaccinated ? 'Sudah Vaksin' : 'Belum Vaksin',
                          style: TextStyle(
                            fontSize: 10,
                            color: pet.vaccinated
                                ? Colors.green[800]
                                : Colors.orange[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${pet.species} • ${pet.breed}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          pet.location,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Rp ${pet.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              pet.rating.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
