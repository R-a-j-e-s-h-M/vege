import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/cart/addmap.dart';
import 'package:vegetable/presentation/cart/address/addressservice.dart';
import 'package:vegetable/presentation/cart/checkout.dart';
import 'package:vegetable/presentation/cart/paymentone.dart';
import 'package:vegetable/presentation/cart/razor.dart';
import 'package:vegetable/presentation/home/customer/customerservice.dart';

class Addressdetails extends StatefulWidget {
  final String money;
  const Addressdetails({super.key, required this.money});

  @override
  State<Addressdetails> createState() => _AddressdetailsState();
}

class _AddressdetailsState extends State<Addressdetails> {
  final AddressService servicee = AddressService();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController landmarkcontroller = TextEditingController();
  double? latitude;
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addresscontroller.dispose();
    phonecontroller.dispose();
    landmarkcontroller.dispose();
  }

  void addadress() {
    servicee.addaddress(
        context: context,
        address: addresscontroller.text,
        phonenumber: phonecontroller.text,
        landmark: landmarkcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<CustomerProvider>().user.address;

    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _addressFormKey,
        child: Column(
          children: [
            if (address.isNotEmpty)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    address,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            Text(
              "Address details",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: addresscontroller,
              decoration: InputDecoration(
                  hintText: "enter the delivery address",
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
                  return "please enter the delivery address";
                }
                return null;
              },
              maxLines: 1,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: landmarkcontroller,
              decoration: InputDecoration(
                  hintText: "near by landmark",
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
                  return "please enter the nearby landmark";
                }
                return null;
              },
              maxLines: 1,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: phonecontroller,
              decoration: InputDecoration(
                  hintText: "phone number",
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
                  return "please enter the phonenumber";
                }
                return null;
              },
              maxLines: 1,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: addadress,
              child: Text("add"),
            ),
            SizedBox(
              height: 60,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(PageTransition(
                    child: Payementpage(pay:widget.money),
                    type: PageTransitionType.bottomToTopPop,
                    childCurrent: Container()));
              },
              child: Text("Check out"),
            )
          ],
        ),
      ),
    ));
  }
}
