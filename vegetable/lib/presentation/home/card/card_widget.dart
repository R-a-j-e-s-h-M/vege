import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/farmerdetails/farmerdb.dart';

import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmerdetails/farmer_detail.dart';
import 'package:vegetable/presentation/farmerdetails/farmermodel.dart';
import 'package:vegetable/presentation/farmerdetails/farmerprovider.dart';

class CardWidget extends StatelessWidget {
  final User farmer;
   int? index;
  CardWidget({super.key,this.index, required this.farmer,});
  DB db = DB();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<FarmerProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: Farmers(
                farmers: farmer.name,
                address: farmer.address,
                district: farmer.district,
                phone: farmer.mobile),
            type: PageTransitionType.bottomToTopPop,
            childCurrent: Container()));

        db.insert(Farmer(
                id: index,
                productId: index.toString(),
                name: farmer.name,
                phone: farmer.mobile,
                address: farmer.address))
            .then(
          (value) {
            cart.addTotalPrice(double.parse(farmer.toString()));
            cart.addCounter();
          },
        );
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/pngwing.com.png"))),
              child: const Center(
                child: Text("u"),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  farmer.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      farmer.place,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      farmer.district,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
