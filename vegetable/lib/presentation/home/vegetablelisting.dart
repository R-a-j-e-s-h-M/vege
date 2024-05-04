import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:vegetable/presentation/home/farmerexplore.dart';

class VegetableListing extends StatefulWidget {
  const VegetableListing({super.key});

  @override
  State<VegetableListing> createState() => _VegetableListingState();
}

class _VegetableListingState extends State<VegetableListing> {
  final List shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Tomato", "40", "assets/images/tomato.jpg", Colors.green],
    ["potato", "25", "assets/images/potato.jpg", Colors.yellow],
    ["beans", "30", "assets/images/beans.jpg", Colors.brown],
    ["carrot", "40", "assets/images/carrot.webp", Colors.blue],
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 700,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's order fresh items for you",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),

          const SizedBox(height: 24),

          // categories -> horizontal listview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Fresh Items",
              style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          // recent orders -> show last 3
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              physics: const NeverScrollableScrollPhysics(),
              itemCount:shopItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
              ),
              itemBuilder: (context, index) {
                return GroceryItemTile(
                  itemName: shopItems[index][0],
                  imagePath: shopItems[index][2],
                  color: shopItems[index][3],
                );
              },
            ),
          ),
        ]));
  }
}


  // list of items on sale
  
// ignore: must_be_immutable
class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final color;
  

  GroceryItemTile({
    super.key,
    required this.itemName,
    required this.imagePath,
    required this.color,
    
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child:  Farmerexplore(
              category:itemName,
            ),
            type: PageTransitionType.rightToLeftWithFade,
            childCurrent: Container()));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color[100],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // item image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(image: AssetImage(imagePath))),
                ),
              ),

              // item name
              Text(
                itemName,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              MaterialButton(
            onPressed: () {
              Navigator.of(context).push(PageTransition(
            child:  Farmerexplore(category: itemName,),
            type: PageTransitionType.rightToLeftWithFade,
            childCurrent: Container()));
              
            },
                color: color,
                child: Text(
                  "Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
