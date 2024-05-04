import 'package:flutter/material.dart';
import 'package:vegetable/presentation/cart/address/addressmodel.dart';
import 'package:vegetable/presentation/cart/address/addressservice.dart';
import 'package:vegetable/presentation/deliveryboy/deliverysevice.dart';
import 'package:vegetable/presentation/farmerui/homepage.dart';

//66358c30c4cc88d616f73ca3
class Deliverypage extends StatefulWidget {
  const Deliverypage({super.key});

  @override
  State<Deliverypage> createState() => _DeliverypageState();
}

class _DeliverypageState extends State<Deliverypage> {
  final DeliveryService addd = DeliveryService();

  List<Addressmodel> address = [];
  final AddressService adservice = AddressService();

  final TextEditingController ordercontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetch();
  }

  // void fetch() async {
  //   address =
  //       await addd.fetchaddress(context: context, id: ordercontroller.text);
  //   setState(() {});
  // }
  fetch() async {
    address = await adservice.fetchAlladdress(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            // TextFormField(
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   controller: ordercontroller,
            //   decoration: InputDecoration(
            //       suffixIcon:
            //           IconButton(onPressed: fetch, icon: Icon(Icons.search)),
            //       hintText: "orderid",
            //       border: const OutlineInputBorder(
            //           borderSide: BorderSide(
            //         color: Colors.black38,
            //       )),
            //       enabledBorder: const OutlineInputBorder(
            //           borderSide: BorderSide(
            //         color: Colors.black38,
            //       ))),
            //   validator: (val) {
            //     if (val!.isEmpty) {
            //       return "please enter the orderid";
            //     }

            //     return null;
            //   },
            //   maxLines: 1,
            // ),
            const Text(
              "Order Address Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
       Container(
        height: 1000,
         child: ListView.builder(itemBuilder: (context, index) {
                final addd = address[index];
                return AddressWidget(address: addd.address,phonenumber: addd.phonenumber,landmark: addd.landmark,);
            },itemCount: address.length,),
       ),
       
          ],
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final String address;
  final String phonenumber;
  final String landmark;
  const AddressWidget({
    super.key,
    required this.address,
    required this.phonenumber,
    required this.landmark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
      ),
      child: Column(
        children: [
          Text(address),
          Text(phonenumber),
          Text(landmark),
        ],
      ),
    );
  }
}
