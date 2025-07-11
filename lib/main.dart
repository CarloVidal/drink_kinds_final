import 'dart:async';
import 'package:flutter/material.dart';
import 'package:drink_kinds_final/favorite.dart';
import 'package:drink_kinds_final/all_drinks.dart';
import 'package:drink_kinds_final/profile.dart';

void main() {
  runApp(const LiquorStoreApp());
}

class LiquorStoreApp extends StatelessWidget {
  const LiquorStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final Color alcoholColor = const Color(0xFFB47B48);

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bg.jpg", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_bar, color: alcoholColor, size: 80),
              const SizedBox(height: 16),
              const Text(
                "DRINK KINDS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alcoholColor,
                  minimumSize: const Size(200, 50),
                ),
                icon: const Icon(Icons.local_drink, color: Colors.white),
                label: const Text(
                  "Browse Drinks",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;
  final Color alcoholColor = const Color(0xFFB47B48);

  // Favorite drinks state
  final List<Map<String, dynamic>> _favoriteDrinks = [];

  void _addToFavorite(Map<String, dynamic> drink) {
    if (!_favoriteDrinks.any((d) => d['name'] == drink['name'])) {
      setState(() {
        _favoriteDrinks.add(drink);
      });
    }
  }

  void _removeFromFavorite(Map<String, dynamic> drink) {
    setState(() {
      _favoriteDrinks.removeWhere((d) => d['name'] == drink['name']);
    });
  }

  // All drinks (for View All)
  List<Map<String, dynamic>> get allDrinks => [
    {
      'name': 'Black Label',
      'type': 'Whiskey',
      'image': 'assets/black.jpg',
    },
    {
      'name': 'Red Wine',
      'type': 'Wine',
      'image': 'assets/red.jpg',
    },
    {
      'name': 'Absolute Vodka',
      'type': 'Vodka',
      'image': 'assets/vodka.jpg',
    },
    {
      'name': 'Jack Daniels',
      'type': 'Whiskey',
      'image': 'assets/jackdeniel.jpg',
    },
    {
      'name': 'Tequila',
      'type': 'Tequila',
      'image': 'assets/tequila.jpg',
    },
    {
      'name': 'Black Label',
      'type': 'Whiskey',
      'image': 'assets/blacklabel.jpg',
    },
    {
      'name': 'Alfonso',
      'type': 'Rum',
      'image': 'assets/alfonso.jpg',
    },
  ];

  List<Widget> get _pages => [
        BrowseDrinksScreen(
          onGoToFavorite: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          onAddFavorite: _addToFavorite,
          favoriteDrinks: _favoriteDrinks,
          allDrinks: allDrinks,
          onRemoveFavorite: _removeFromFavorite,
        ),
        FavoriteScreen(
          favoriteDrinks: _favoriteDrinks,
          onRemoveFavorite: (drink) {
            deleteItem(context, () => _removeFromFavorite(drink));
          },
          onRemoveAllFavorites: () {
            setState(() {
              _favoriteDrinks.clear();
            });
          },
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: alcoholColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_bar),
            label: 'Alcohol',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}

class BrowseDrinksScreen extends StatefulWidget {
  final VoidCallback onGoToFavorite;
  final void Function(Map<String, dynamic>) onAddFavorite;
  final List<Map<String, dynamic>> favoriteDrinks;
  final List<Map<String, dynamic>> allDrinks;
  final void Function(Map<String, dynamic>) onRemoveFavorite;

  const BrowseDrinksScreen({
    super.key,
    required this.onGoToFavorite,
    required this.onAddFavorite,
    required this.favoriteDrinks,
    required this.allDrinks,
    required this.onRemoveFavorite,
  });

  @override
  State<BrowseDrinksScreen> createState() => _BrowseDrinksScreenState();
}

class _BrowseDrinksScreenState extends State<BrowseDrinksScreen> {
  final List<String> recommendedImages = [
    'assets/corousel1.jpg',
    'assets/corousel2.jpg',
    'assets/corousel3.jpg',
    'assets/corousel4.jpg',
  ];

  final List<Map<String, dynamic>> hotSellerDrinks = [
    {
      'name': 'Black Label',
      'type': 'Whiskey',
      'image': 'assets/black.jpg',
    },
    {
      'name': 'Red Wine',
      'type': 'Wine',
      'image': 'assets/red.jpg',
    },
    {
      'name': 'Absolute Vodka',
      'type': 'Vodka',
      'image': 'assets/vodka.jpg',
    },
    {
      'name': 'Jack Daniels',
      'type': 'Whiskey',
      'image': 'assets/jackdeniel.jpg',
    },

  ];

  int _currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _timer;

  final Color alcoholColor = const Color(0xFFB47B48);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < recommendedImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: alcoholColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: recommendedImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        recommendedImages[index],
                        fit: BoxFit.cover,
                        width: 300,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                recommendedImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? alcoholColor
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular Drinks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDrinksScreen(
                            allDrinks: widget.allDrinks,
                            favoriteDrinks: widget.favoriteDrinks,
                            onAddFavorite: widget.onAddFavorite,
                            onRemoveFavorite: widget.onRemoveFavorite,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: alcoholColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: hotSellerDrinks.length,
              itemBuilder: (context, index) {
                final drink = hotSellerDrinks[index];
                final isFavorite = widget.favoriteDrinks.any((d) => d['name'] == drink['name']);
                return DrinkCard(
                  drink: drink,
                  isFavorite: isFavorite,
                  onAdd: () {
                    widget.onAddFavorite(drink);
                  },
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  final VoidCallback onAdd;
  final bool isFavorite;

  const DrinkCard({super.key, required this.drink, required this.onAdd, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: isFavorite ? Colors.grey : const Color(0xFFB47B48),
              minimumSize: const Size(100, 36),
            ),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 18,
            ),
            label: Text(
              isFavorite ? "Favorited" : "Favorite",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: isFavorite ? null : onAdd,
          ),
        ],
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteDrinks;
  final void Function(Map<String, dynamic>) onRemoveFavorite;
  final VoidCallback? onRemoveAllFavorites;

  const FavoriteScreen({super.key, required this.favoriteDrinks, required this.onRemoveFavorite, this.onRemoveAllFavorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB47B48),
        title: const Text("Favorite"),
        actions: [
          if (favoriteDrinks.isNotEmpty && onRemoveAllFavorites != null)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.white),
              tooltip: 'Delete All',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete All'),
                    content: const Text('Are you sure you want to delete all favorites?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onRemoveAllFavorites!();
                        },
                        child: const Text('Delete All'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: favoriteDrinks.isEmpty
          ? const Center(
              child: Text(
                "Your favorite drinks will appear here.",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favoriteDrinks.length,
              itemBuilder: (context, index) {
                final drink = favoriteDrinks[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      drink['image'],
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    drink['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    drink['type'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => onRemoveFavorite(drink),
                  ),
                );
              },
            ),
    );
  }
}

// New screen for View All
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
          return DrinkCard(
            drink: drink,
            isFavorite: isFavorite,
            onAdd: () {
              onAddFavorite(drink);
            },
          );
        },
      ),
    );
  }
}
