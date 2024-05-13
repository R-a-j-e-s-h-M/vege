import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/fetchmap/fetch_map_location.dart';
import 'package:vegetable/presentation/home/account.dart';


class Appbarwidget extends StatefulWidget {

  const Appbarwidget({super.key});

  @override
  State<Appbarwidget> createState() => _AppbarwidgetState();
}

class _AppbarwidgetState extends State<Appbarwidget> {
   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child:  Account(pagechanged: true,),
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: Container()));
                      
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
