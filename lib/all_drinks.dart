import 'package:flutter/material.dart';

class AllDrinksScreen extends StatelessWidget {
  final List<Map<String, dynamic>> allDrinks;
  final List<Map<String, dynamic>> favoriteDrinks;
  final void Function(Map<String, dynamic>) onAddFavorite;
  final void Function(Map<String, dynamic>) onRemoveFavorite;

  const AllDrinksScreen({
    super.key,
    required this.allDrinks,
    required this.favoriteDrinks,
    required this.onAddFavorite,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB47B48),
        title: const Text("All Drinks"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: allDrinks.length,
        itemBuilder: (context, index) {
          final drink = allDrinks[index];
          final isFavorite = favoriteDrinks.any((d) => d['name'] == drink['name']);
          return _DrinkCard(
            drink: drink,
            isFavorite: isFavorite,
            onAdd: () => onAddFavorite(drink),
            onRemove: () => onRemoveFavorite(drink),
          );
        },
      ),
    );
  }
}

class _DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isFavorite;

  const _DrinkCard({super.key, required this.drink, required this.onAdd, required this.onRemove, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.08,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 63, 53, 116),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                drink['image'],
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              drink['name'],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              drink['type'],
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            isFavorite
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(100, 36),
                    ),
                    icon: const Icon(Icons.delete, color: Colors.white, size: 18),
                    label: const Text("Remove", style: TextStyle(color: Colors.white)),
                    onPressed: onRemove,
                  )
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB47B48),
                      minimumSize: const Size(100, 36),
                    ),
                    icon: const Icon(Icons.favorite_border, color: Colors.white, size: 18),
                    label: const Text("Favorite", style: TextStyle(color: Colors.white)),
                    onPressed: onAdd,
                  ),
          ],
        ),
      ),
    );
  }
} 