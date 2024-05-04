/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationFetch extends StatefulWidget {
  const UserLocationFetch({super.key});

  @override
  State<UserLocationFetch> createState() => _UserLocationFetchState();
}

class _UserLocationFetchState extends State<UserLocationFetch> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:vegetable/presentation/main_page/bottomnavbar/screenmainpage.dart';



class CurrentLocationFetching extends StatelessWidget {
  const CurrentLocationFetching({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:ListView(
          children:[ Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 50,
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
                  child: Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                     const   Icon(Icons.search),
                        Container(
                          height: 50,
                          width: 250,
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "search the current location",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
           const   Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Or",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 15),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child:  Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.map_rounded),
                            Expanded(child: Padding(padding:EdgeInsets.symmetric(horizontal: 15), child:Text("Use the current location"))),
                                    
        
                            
                                ],
        
                              )
                        )),
                       
                      ],
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        const   SizedBox(height: 60,),
                        Container(
                          height: 30,
                          width: 50,
                          
                          child: TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScreenMainpage()));
                          }, child:Text("next") ),
                        )
                        ,
        ]
        ),
      ),
    );
  }
}
