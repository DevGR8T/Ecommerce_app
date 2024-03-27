import 'package:ecommerce_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/cartpage.dart';
import 'package:ecommerce_app/pages/favoritepage.dart';

import 'package:ecommerce_app/pages/profilepage.dart';

class RootPage extends StatefulWidget {
  RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selecteditem = 0;

  List<Widget> pages = [
    HomePage(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selecteditem],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selecteditem,
          onTap: (value) {
            setState(() {
              selecteditem = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
