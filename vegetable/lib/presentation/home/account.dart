import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/home/customer/customer.dart';



// ignore: must_be_immutable
class Account extends StatelessWidget {
  Account({super.key, required this.pagechanged});
  bool pagechanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 200,
                  ),
               
           const       SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {},
                      child:const Text("Please Register here",style:TextStyle(fontSize: 30,color: Colors.black,),textAlign: TextAlign.center,) ,),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child: const Customerform(),
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
                          child: const Center(child: Text("Register")),
                        ),
                      ))
                ],
              )
           );
  }
}
