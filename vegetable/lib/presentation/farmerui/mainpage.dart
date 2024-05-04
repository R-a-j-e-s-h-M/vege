import 'package:flutter/material.dart';
import 'package:vegetable/presentation/farmer/farmersignup.dart';
import 'package:vegetable/presentation/farmer/favorites.dart';
import 'package:vegetable/presentation/farmerdetails/farmer_detail.dart';
import 'package:vegetable/presentation/farmerui/bottomnav.dart';
import 'package:vegetable/presentation/farmerui/homepage.dart';
import 'package:vegetable/presentation/home/home.dart';




class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}
final List _pages = [
   const Homeone(),
   Favorites(),
    
   
   
   
  ];
class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ValueListenableBuilder(
          valueListenable: changevalue,
          builder: ((context, int value, _) => _pages[value])),
      bottomNavigationBar: const Bottomnavigationone(),
    );
  }
}