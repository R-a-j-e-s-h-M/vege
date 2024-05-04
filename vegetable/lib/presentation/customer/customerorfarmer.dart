

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/deliveryboy/deliverpage.dart';
import 'package:vegetable/presentation/deliveryboy/deliveryboy.dart';
import 'package:vegetable/presentation/farmerui/mainpage.dart';
import 'package:vegetable/presentation/home/home.dart';
import 'package:vegetable/presentation/main_page/bottomnavbar/screenmainpage.dart';





class Customerorfarmer extends StatefulWidget {
  const Customerorfarmer({super.key});

  @override
  State<Customerorfarmer> createState() => _CustomerorfarmerState();
}

class _CustomerorfarmerState extends State<Customerorfarmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child:  ScreenMainpage(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Center(child: Text("Customer")),
                        ),
                        
                      )),
                      Text("or"),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child:  Mainpage(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Center(child: Text("Farmer")),
                        ),
                      )),
                     const Text("or"),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child:  Deliverypage(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Center(child: Text("Delivery boy")),
                        ),
                      ))

        ],
      )),
    );
  }
}