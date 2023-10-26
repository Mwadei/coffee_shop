import 'package:cofee_flutter/screens/home/cart_screen.dart';
import 'package:cofee_flutter/screens/home/favorites_screen.dart';
import 'package:cofee_flutter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Screens extends StatefulWidget {
  static const screenRoute = '/screens';
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int _selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    HomeScreen(),
    Favorites(),
    CartPage(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: GNav(
        //select index
        selectedIndex: _selectedIndex,
        onTabChange: navigateBottomBar,
        ///////////////////
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.secondary,
        activeColor: Theme.of(context).colorScheme.secondary,
        tabBackgroundColor: Color(0xFFE57734).withOpacity(0.7),
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
          ),
          GButton(
            icon: Icons.favorite_border,
            text: "Favorite",
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: "cart",
          ),
        ],
      ),
    );
  }
}
