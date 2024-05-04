import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:vegetable/presentation/myorder/timelineui.dart';

class TrackOrder extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TrackOrder({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  String packed = "packed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(
        title: "Track My Order",
        child: DefaultBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: ListView(
          children:  [
            TimeLineTileUI(
              isFirst: true,
              isLast: false,
              isPast: true,
              eventChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.book_online, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Order Placed.',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    'Your order is placed successfully. It is yet to be packed & shipped.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TimeLineTileUI(
              isFirst: false,
              isLast: false,
              isPast: packed.length>5?true:false,
              eventChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Order Is Packed',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    'Your order is packed & ready to dispatch from our warehouse.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TimeLineTileUI(
              isFirst: false,
              isLast: false,
              isPast: packed.length>10?true:false,
              eventChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Order Dispatched',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    'Your order is dispatched from our warehouse, it will take 5-7 working days for you to get the delivery.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TimeLineTileUI(
              isFirst: false,
              isLast: true,
              isPast: true,
              eventChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.home_work, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Order Delivery',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    'You will get your order on 8th of December, please be available at your address to receive the order.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  // ignore: prefer_typing_uninitialized_variables
  final action;
  const DefaultAppBar({
    Key? key,
    required this.title,
    required this.child,
    this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    const kWhiteColor = Color(0xFFFFFFFF);
    const kRadius = 0.0;
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: kWhiteColor,
      elevation: kRadius,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: child,
      actions: action,
    );
  }
}

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}




/** 

Container(
                
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                 const Icon(Icons.home, size: 64.0, color: Colors.black),
                const  SizedBox(width: 32.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const Text(
                        "Delivery Address",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "Home, Work & Other Address",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          "House No: 1234, 2nd Floor Sector 18, Silicon Valey Amerika Serikat",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            */