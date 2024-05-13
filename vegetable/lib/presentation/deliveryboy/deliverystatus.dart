import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/cart/cartpage.dart';
import 'package:vegetable/presentation/deliveryboy/deliver.dart';
import 'package:vegetable/presentation/deliveryboy/deliveryotp.dart';
import 'package:vegetable/presentation/farmerdetails/farmermodel.dart';
import 'package:vegetable/presentation/farmerdetails/farmerprovider.dart';
import 'package:vegetable/presentation/farmerui/homepage.dart';
import 'package:vegetable/presentation/myorder/ordermodel.dart';
import 'package:vegetable/presentation/myorder/orderservice.dart';

class DeliveryStatus extends StatefulWidget {
  
  const DeliveryStatus(
      {super.key,
    });

  @override
  State<DeliveryStatus> createState() => _DeliveryStatusState();
}

class _DeliveryStatusState extends State<DeliveryStatus> {
  final TextEditingController orderplaced = TextEditingController();
  final TextEditingController orderpacked = TextEditingController();
  final TextEditingController orderdispached = TextEditingController();
  final TextEditingController orderdelivered = TextEditingController();

  final Orderdeliveredservice orderdeliver = Orderdeliveredservice();
  final Orderdispatchedservice orderdispatch = Orderdispatchedservice();
  final Orderplacedservice orderplace = Orderplacedservice();
  final Orderpackedservice orderpack = Orderpackedservice();

  @override
  void initState() {
    super.initState();
  }

  addorderdelivered() {
    orderdeliver.adddelivered(
        context: context, orderdelivered: orderdelivered.text);
  }

  addorderplaced() {
    orderplace.addplaced(context: context, orderplaced: orderplaced.text);
  }

  addorderpacked() {
    orderpack.addpacked(context: context, orderpacked: orderpacked.text);
  }

  addorderdispatched() {
    orderdispatch.adddispatched(
        context: context, orderdispatched: orderdispached.text);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<FarmerProvider>(context);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
                TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: orderplaced,
            decoration: InputDecoration(
                hintText: "order placed",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter the order is placed";
              }
              return null;
            },
            maxLines: 1,
                ),
                 Text(
                    'Your order is placed successfully. It is yet to be packed & shipped.',
                    style: TextStyle(color: Colors.black),
                  ),
                MaterialButton(
                  color: Colors.grey,
            onPressed: addorderplaced,
            child: Text("order is placed"),
                ),
                TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: orderpacked,
            decoration: InputDecoration(
                hintText: "order is packed",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter the order is packed";
              }
              return null;
            },
            maxLines: 1,
                ),
                Text(
                    'Your order is dispatched from our warehouse, it will take 5-7 working days for you to get the delivery.',
                    style: TextStyle(color: Colors.black),
                  ),
                MaterialButton(
                  color: Colors.grey,
            onPressed: addorderpacked,
            child: Text("order packed"),
                ),
                SizedBox(
            height: 10,
                ),
                TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: orderdispached,
            decoration: InputDecoration(
                hintText: "order is dispatched",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter the order is dispatchd";
              }
              return null;
            },
            maxLines: 1,
                ),
                Text(
                    'Your order is dispatched from our warehouse, it will take 5-7 working days for you to get the delivery.',
                    style: TextStyle(color: Colors.black),
                  ),
                MaterialButton(
                  color: Colors.grey,
            onPressed: addorderdispatched,
            child: Text("order dispatched"),
                ),
                SizedBox(
            height: 10,
                ),
                TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: orderdelivered,
            decoration: InputDecoration(
                hintText: "order is delivered",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter the order is delivered";
              }
              return null;
            },
            maxLines: 1,
                ),
                Text(
                    'You will get your order on 8th of December, please be available at your address to receive the order.',
                    style: TextStyle(color: Colors.black),
                  ),
                MaterialButton(
                  color: Colors.grey,
            onPressed: addorderdelivered,
            child: Text("order delivered"),
                ),
                SizedBox(
            height: 10,
                ),
          
                SizedBox(
            height: 10
                ),
        
                 MaterialButton(onPressed: (){
                      Navigator.of(context).push(PageTransition(
                                child:  Deliver(),
                                type: PageTransitionType.bottomToTopJoined,
                                childCurrent: Container()));
        
              },child: Text("Farmer address",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),



              MaterialButton(onPressed: (){
                      Navigator.of(context).push(PageTransition(
                                child:  AuthEmailAp(),
                                type: PageTransitionType.bottomToTopJoined,
                                childCurrent: Container()));
        
              },child: Text("Otp verification for Customer",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            ])),
        ));
  }
}
