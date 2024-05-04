import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/farmer/farmersignup.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

bool pagechanged = true;

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pagechanged
            ? ListView(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 200,
                  ),
                  const Text(
                    "Are you an farmer",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Please sign up here",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    
                    child: Container(
                  
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                         fit: BoxFit.cover,
                          alignment: Alignment.center,
                            image: AssetImage("assets/images/farmer.jpg")),
                      ),
                    ),
                  ),
                 const SizedBox(height: 20,),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child:const  Farmersignup(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Center(child: Text("Register",style: TextStyle(color: Colors.white),)),
                        ),
                      ))
                ],
              )
            : ListView(
                children: const [Text("pagechanged")],
              ));
  }
}
