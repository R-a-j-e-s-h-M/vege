import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/cart/cartmodel.dart';
import 'package:vegetable/presentation/cart/cartpage.dart';
import 'package:vegetable/presentation/cart/cartprovider.dart';
import 'package:vegetable/presentation/cart/dbhelper.dart';
import 'package:vegetable/presentation/cart/productdetailservice.dart';
import 'package:vegetable/presentation/farmer/farmeradminservice.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmer/productmodel.dart';

import 'package:vegetable/presentation/farmerdetails/profiletap.dart';
import 'package:vegetable/presentation/farmerdetails/review/reviews.dart';
import 'package:vegetable/presentation/home/farmerexplore.dart';
import 'package:vegetable/presentation/home/vegetablelisting.dart';

// ignore: must_be_immutable
class Farmers extends StatefulWidget {
  String farmers;
  String address;
  String district;
  String phone;
  List<dynamic>? vegetables;

  Farmers(
      {super.key,
      required this.farmers,
      required this.address,
      required this.district,
      required this.phone,
      this.vegetables});

  @override
  State<Farmers> createState() => _FarmersState();
}

class _FarmersState extends State<Farmers> {
  List<User>? user;
  final AuthService authservice = AuthService();

  final AdminServices adminServices = AdminServices();

  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchfarmerdetails();
    fetchAllProducts();
  }

  fetchfarmerdetails() async {
    user = await authservice.fetchAllProducts(context);
    setState(() {});
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProductss(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.vegetable;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/farmer.jpg",
              height: 400,
            ),
          ),
          buttonArrow(context),
          DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1.0,
              minChildSize: 0.6,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 35,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Farmer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "District:${widget.district}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Phone:${widget.phone}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileTap(
                                          name: widget.farmers,
                                          showFollowBottomInProfile: true),
                                    ));
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/pngwing.com.png"),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.farmers,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xFF1FCC79),
                              child: IconButton(
                                icon: const Icon(Icons.heart_broken),
                                color: Colors.white,
                                onPressed: () {
                                  print(user![0].vegetable![0]);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                              height: 10,
                            ),
                            const Expanded(
                              child: Text(
                                "273 Likes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                    child: Reviews(),
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    childCurrent: Container()));
                              },
                              color: Colors.black,
                              child: const Text(
                                "Reviews",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            height: 4,
                          ),
                        ),
                        const Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.address,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            height: 4,
                          ),
                        ),
                        const Text(
                          "Vegetables",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        products == null
                            ? const Loader()
                            : SizedBox(
                                height: 300,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      //      final vegetable =
                                      //   widget.vegetable![index];
                                      //      final vegetabless = user![index];
                                      //      final vegetable =     vegetabless.vegetable![0]['product'];
                                      final vegetable = products![index];
                                      return ingredients(
                                          context,
                                          vegetable.name,
                                          vegetable.quantity.toString());
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        height: 5,
                                      );
                                    },
                                    itemCount: products!.length),
                              ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            height: 4,
                          ),
                        ),
                        const Text(
                          "Vegetable list",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        products == null
                            ? const Loader()
                            : SizedBox(
                                height: 1000,
                                child: GridView.builder(
                                  padding: const EdgeInsets.all(12),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: products!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.2,
                                  ),
                                  itemBuilder: (context, index) {
                                    // final vegetable = widget.vegetable![index];
                                    // final vegetable = Product.fromMap( productCart![index]['product']);

                                   // final vegetable = Product.fromMap(
                                    //    user![0].vegetable![0]['product']);
                                    //final vegetable =  vegetabless.vegetable![0]['vegetable'];
                                    final vegetable = products![index];
                                    return GroceryItemTile(
                                      itemName: vegetable.name,
                                      itemPrice: vegetable.price.toString(),
                                      imagePath: vegetable.images![0],
                                      vegetable: vegetable,
                                      index: index,
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final Product vegetable;
  final int index;
  final TextEditingController quantitycontroller = TextEditingController();
  GroceryItemTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.imagePath,
      required this.vegetable,
      required this.index});
  final ProductDetailsServices productdetail = ProductDetailsServices();
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {
        //   Navigator.of(context).push(PageTransition(
        //      child: const CartPage(),
        //     type: PageTransitionType.rightToLeftWithFade,
        //    childCurrent: Container()));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // item image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(image: NetworkImage(imagePath))),
                ),
              ),

              // item name
              Text(
                itemName,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              MaterialButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: quantitycontroller,
                                  decoration: InputDecoration(
                                      hintText: "Add quantity in kilogram",
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.black38,
                                      )),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.black38,
                                      ))),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "please enter the quantity";
                                    }
                                  },
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 10),
                                MaterialButton(
                                  onPressed: () {
                                    
                                    print(index);
                                    print(vegetable.name.toString());
                                    print(vegetable.price.toString());
                                    
                                    print('1');
                                    
                                    print(vegetable.images![0].toString());

                                    dbHelper!
                                        .insert(Cart(
                                            id: index,
                                            productId: index.toString(),
                                            productName:
                                                vegetable.name.toString(),
                                            initialPrice: vegetable.price.round(),
                                            productPrice: vegetable.price.round(),
                                            quantity:int.parse( quantitycontroller.text),
                                            unitTag:
                                                "gram",
                                            image:
                                                vegetable.images![0].toString()))
                                        .then((value) {
                                      cart.addTotalPrice(double.parse(
                                          vegetable.toString()));
                                      cart.addCounter();

                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text('Product is added to cart'),
                                        duration: Duration(seconds: 1),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }).onError((error, stackTrace) {
                                      print("error" + error.toString());
                                      final snackBar = SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Product is already added in cart'),
                                          duration: Duration(seconds: 1));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                    /** 
                                    List<Product> vege;
                                    print(vegetable.id);
                                    print(vegetable.id!.isEmpty);
                                    productdetail.addToCart(
                                        context: context, product: vegetable);
                                    Navigator.of(context).push(PageTransition(
                                        child: CartPage(
                                          product: vegetable,
                                        ),
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        childCurrent: Container()));**/
                                  },
                                  color: Colors.black,
                                  child: Text(
                                    'Add to cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                color: Colors.black,
                child: Text(
                  '\Rs' + itemPrice,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

buttonArrow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}

ingredients(BuildContext context, String vegetable, String quantity) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xFFE3FFF8),
              child: Icon(
                Icons.done,
                size: 15,
                color: Color(0xFF1FCC79),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              vegetable,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      const Text("out of stock")
    ],
  );
}
