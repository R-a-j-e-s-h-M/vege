import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/cart/address/addressmodel.dart';
import 'package:vegetable/presentation/cart/address/addressservice.dart';
import 'package:vegetable/presentation/cart/cartmodel.dart';
import 'package:vegetable/presentation/cart/cartprovider.dart';
import 'package:vegetable/presentation/cart/dbhelper.dart';
import 'package:vegetable/presentation/deliveryboy/deliverysevice.dart';
import 'package:vegetable/presentation/deliveryboy/deliverystatus.dart';
import 'package:badges/badges.dart' as badges;
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
 DBHelper? dbHelper = DBHelper();
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
     final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegetable details'),
        centerTitle: true,
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      
                    } else {
                      return snapshot.data ==null?Loader(): Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(snapshot
                                                .data![index].image
                                                .toString()),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .productName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data![index].unitTag
                                                          .toString() +
                                                      " " +
                                                      r"Rs" +
                                                      snapshot.data![index]
                                                          .productPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }
                  return Text('');
                }),
            Consumer<CartProvider>(builder: (context, value, child) {
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                    ? false
                    : true,
                child: FutureBuilder(
                    future: cart.getData(),
                    builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                      int totalprice = 0;
                      int? price1 = snapshot.data![0].productPrice;
                     int? price2 = snapshot.data![1].productPrice;
                      // int? price3 = snapshot.data![0].productPrice;
                      totalprice = totalprice + price1!+price2! ;

                      return Column(
                        children: [
                          ReusableWidget(
                            title: 'Sub Total',
                            value: r'Rs' +
                                value.getTotalPrice().toStringAsFixed(2),
                          ),
                          ReusableWidget(
                            title: 'Discout 5%',
                            value: r'Rs' + '20',
                          ),
                          ReusableWidget(
                            title: 'Total',
                            value: r'Rs' +
                                totalprice.toString(),
                          ),
                         MaterialButton(onPressed: (){
                    Navigator.of(context).push(PageTransition(
                              child:  DeliveryStatus(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));

            },child: Text("Delivery status",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            
                        ],
                      );
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
    
    /*
    
    Scaffold(
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
            MaterialButton(onPressed: (){
                    Navigator.of(context).push(PageTransition(
                              child:  DeliveryStatus(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));

            },child: Text("Delivery status",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
       


       
       
          ],
        ),
      ),
    );*/




/*

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
*/