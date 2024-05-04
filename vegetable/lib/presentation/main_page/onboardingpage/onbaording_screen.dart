import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vegetable/fetchmap/fetch_map_location.dart';
import 'package:vegetable/presentation/main_page/otp/otp.dart';



class Onboardingscreen extends StatelessWidget {
  Onboardingscreen({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
        title: "Order directly from farmer",
        body: "You're supporting local communities and the economy by keeping money within the agricultural system",
        image:const Image(image: AssetImage("assets/images/farmers.jpg")),
        
        decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
    
    PageViewModel(
        title: "Deliver to your door step",
        body: "From our doorstep to yours-swift,secure,contactless delivery",
        image:const Image(image: AssetImage("assets/images/deliver.webp")),
        decoration:const  PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: "Select  payment method",
        body: "For seamless transaction,Choose your payment path your convenience our priority",
         image:const Image(image: AssetImage("assets/images/sec.jpg")),
        
        decoration:const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: IntroductionScreen(
        pages: pages,
        dotsDecorator: const DotsDecorator(
            size: Size(10, 10),
            color: Colors.green,
            activeSize: Size.square(15),
            activeColor: Colors.red),
        showDoneButton: true,
        done:  Container(
          height: 40,
          width: 100,
          decoration:BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child:const Center(child: Text("Get started",style: TextStyle(color: Colors.white,),)),),
      
        showSkipButton: true,
        skip:  Container(
          height: 40,
          width: 100,
          decoration:BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child:const Center(child: Text("skip",style: TextStyle(color: Colors.white,),)),),
       
        showNextButton: true,
        next: Container(
          height: 40,
          width: 100,
          decoration:BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child:const Center(child: Text("Next",style: TextStyle(color: Colors.white,),)),),
        onDone: ()=>onDone(context),
        ),
        
      );
    
  }

  void onDone(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>LoginPage()));
  }
}


