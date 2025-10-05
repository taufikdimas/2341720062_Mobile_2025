import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:belanja_27/models/item.dart';

class ItemPage extends StatefulWidget {
  final dynamic item;
  const ItemPage({super.key, this.item});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final itemArgs = (widget.item ?? ModalRoute.of(context)?.settings.arguments) as Item;
    final photos = itemArgs.photos.isNotEmpty
        ? itemArgs.photos
        : (itemArgs.photo != null ? [itemArgs.photo!] : []);

    return Scaffold(
      appBar: AppBar(
        title: Text(itemArgs.name),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (photos.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    height: 320,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: photos.length,
                                onPageChanged: (i) =>
                                    setState(() => _currentIndex = i),
                                itemBuilder: (context, index) {
                                  final tag = photos[index] ?? itemArgs.name;
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Hero(
                                      tag: tag,
                                      flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                                        final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                                        return AnimatedBuilder(
                                          animation: curved,
                                          builder: (context, child) {
                                            final t = curved.value;
                                            return Opacity(
                                              opacity: lerpDouble(0.95, 1.0, t)!,
                                              child: Transform.scale(
                                                scale: lerpDouble(1.06, 1.0, t)!,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: lerpDouble(12, 0, t) ?? 0.0,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.lerp(BorderRadius.circular(22), BorderRadius.circular(18), t) ?? BorderRadius.circular(18),
                                                    child: child,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            photos[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        photos[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          Positioned(
                            right: 18,
                            top: 18,
                            child: Card(
                              color: Colors.white.withOpacity(0.95),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      itemArgs.rating.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _currentIndex = index);
                      },
                      child: Card(
                        elevation: _currentIndex == index ? 5 : 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: photos[index] ?? itemArgs.name,
                                  child: Image.asset(
                                    photos[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) =>
                                        Container(color: Colors.grey[300]),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: photos.length,
                ),
              ),
              const SizedBox(height: 10),
            ],

            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            itemArgs.name,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Rp ${itemArgs.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${itemArgs.species} • ${itemArgs.breed}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const Spacer(),
                        Icon(
                          itemArgs.gender.toLowerCase() == 'male'
                              ? Icons.male
                              : Icons.female,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          itemArgs.gender,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Icon(Icons.cake, size: 18, color: Colors.grey[700]),
                        const SizedBox(width: 6),
                        Text(
                          '${(itemArgs.ageMonths / 12).floor()}y ${itemArgs.ageMonths % 12}m',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 18),
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 6),
                        Text(itemArgs.location),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      itemArgs.description,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart_checkout),
                            label: const Text('Adopt / Buy'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.message),
                          label: const Text('Contact'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: itemArgs.vaccinated
                                ? Colors.green[50]
                                : Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                itemArgs.vaccinated
                                    ? Icons.verified
                                    : Icons.warning_amber,
                                color: itemArgs.vaccinated
                                    ? Colors.green[700]
                                    : Colors.orange[700],
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                itemArgs.vaccinated
                                    ? 'Vaccinated'
                                    : 'Not vaccinated',
                                style: TextStyle(
                                  color: itemArgs.vaccinated
                                      ? Colors.green[800]
                                      : Colors.orange[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Fee: Rp ${itemArgs.price}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
