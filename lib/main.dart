import 'dart:async';
import 'package:flutter/material.dart';
import 'package:drink_kinds_final/favorite.dart';

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

  List<Widget> get _pages => [
        BrowseDrinksScreen(
          onGoToFavorite: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        const FavoriteScreen(),
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

  const BrowseDrinksScreen({super.key, required this.onGoToFavorite});

  @override
  State<BrowseDrinksScreen> createState() => _BrowseDrinksScreenState();
}

class _BrowseDrinksScreenState extends State<BrowseDrinksScreen> {
  final List<String> recommendedImages = [
    'assets/black.jpg',
    'assets/red.jpg',
    'assets/vodka.jpg',
    'assets/jackdeniel.jpg',
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
                    onPressed: () {},
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
                return DrinkCard(
                  drink: drink,
                  onAdd: () {
                    // You can implement favorite logic here if needed
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alcoholColor,
                  minimumSize: const Size(180, 48),
                ),
                icon: const Icon(Icons.favorite, color: Colors.white),
                label: const Text(
                  "Go to Favorite",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: widget.onGoToFavorite,
              ),
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

  const DrinkCard({super.key, required this.drink, required this.onAdd});

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
              backgroundColor: const Color(0xFFB47B48),
              minimumSize: const Size(100, 36),
            ),
            icon: const Icon(Icons.favorite_border,
                color: Colors.white, size: 18),
            label: const Text(
              "Favorite",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB47B48),
        title: const Text("Favorite"),
      ),
      body: const Center(
        child: Text(
          "Your favorite drinks will appear here.",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
