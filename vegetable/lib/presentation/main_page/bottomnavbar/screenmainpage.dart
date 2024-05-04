import 'package:flutter/material.dart';
import 'package:vegetable/presentation/cart/cartpage.dart';

import 'package:vegetable/presentation/myorder/myorder.dart';

import 'package:vegetable/presentation/farmer/favorites.dart';
import 'package:vegetable/presentation/home/home.dart';
import 'package:vegetable/presentation/main_page/bottomnavbar/bottom_nav_bar.dart';

class ScreenMainpage extends StatelessWidget {
   ScreenMainpage({super.key});
  final List _pages = [
   const Home(),
   
   const CartPage(),
   TrackOrder(),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ValueListenableBuilder(
          valueListenable: changevalue,
          builder: ((context, int value, _) => _pages[value])),
      bottomNavigationBar: const Bottomnavigation(),
    );
  }
}
