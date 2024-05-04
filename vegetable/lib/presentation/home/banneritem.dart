import 'package:flutter/material.dart';
import 'package:vegetable/presentation/home/appbannerlist.dart';






class Banneritem extends StatelessWidget {
  final Appbanner? appbanner;

  const Banneritem({
    super.key,
    this.appbanner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image:AssetImage("assets/images/discount.jpg"),
      
          )),
      child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Center(
                child: Column(
                  children: [
                    Text("".toUpperCase()),
                    SizedBox(
                      width: 200,
                      child: Text(
                        appbanner!.title.toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
