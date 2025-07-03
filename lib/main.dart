import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(LiquorStoreApp());
}

class LiquorStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final Color alcoholColor = Color(0xFFB47B48);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bg.jpg", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_bar, color: alcoholColor, size: 80),
              SizedBox(height: 16),
              Text(
                "DRINK KINDS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alcoholColor,
                  minimumSize: Size(200, 50),
                ),
                icon: Icon(Icons.local_drink, color: Colors.white),
                label: Text(
                  "Browse Drinks",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BrowseDrinksScreen()),
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

class BrowseDrinksScreen extends StatefulWidget {
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
  int cartCount = 0;

  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < recommendedImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
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

  final Color alcoholColor = Color(0xFFB47B48);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: alcoholColor,
        // title: Text("List of Drinks"),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel/Slideshow at the top
            SizedBox(height: 16),
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
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                recommendedImages.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? alcoholColor : Colors.white54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            // Hot Seller Drinks Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot Seller Drinks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // You can implement "View All" navigation here
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    setState(() {
                      cartItems.add(drink);
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  final VoidCallback onAdd;

  const DrinkCard({required this.drink, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 63, 53, 116),
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
          SizedBox(height: 8),
          Text(
            drink['name'],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            drink['type'],
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFB47B48),
              minimumSize: Size(100, 36),
            ),
            icon: Icon(Icons.add_shopping_cart, color: Colors.white, size: 18),
            label: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: Color(0xFFB47B48),
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Text(
                      "Your cart is empty.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          item['type'],
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Cancel and go back
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Ok and go back
                  },
                  child: Text("OK"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB47B48),
                  ),
                  onPressed: () {
                    // Implement purchase logic here
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Purchase"),
                        content: Text("Thank you for your purchase!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Purchase"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
