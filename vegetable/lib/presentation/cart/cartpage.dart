import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/cart/address/addadress.dart';
import 'package:vegetable/presentation/cart/cartmodel.dart';
import 'package:vegetable/presentation/cart/cartprovider.dart';
import 'package:vegetable/presentation/cart/dbhelper.dart';
import 'package:vegetable/presentation/cart/razor.dart';
import 'package:vegetable/presentation/farmer/productmodel.dart';
import 'package:vegetable/presentation/home/vegetablelisting.dart';
import 'package:badges/badges.dart' as badges;

class CartPage extends StatefulWidget {
  final Product? product;
  const CartPage({super.key, this.product});

  @override
  State<CartPage> createState() => _CartPageState();
}
DBHelper? dbHelper = DBHelper();

@override
void initState() {
  initState();

}





class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Shopping Cart'),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value , child){
                  return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                },

              ),
          
              badgeAnimation:badges.BadgeAnimation.slide(),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
              future:cart.getData() ,
                builder: (context , AsyncSnapshot<List<Cart>> snapshot){
                if(snapshot.hasData){

                  if(snapshot.data!.isEmpty){
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          
                          SizedBox(height: 20,),
                          Text('Your cart is empty 😌' ,style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 20,),
                          Text('Explore products and shop your\nfavourite items' , textAlign: TextAlign.center ,style: Theme.of(context).textTheme.subtitle2)

                        ],
                      ),
                    );
                  }else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(snapshot.data![index].image.toString()),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot.data![index].productName.toString() ,
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                  ),
                                                  InkWell(
                                                      onTap: (){
                                                        dbHelper!.delete(snapshot.data![index].id!);
                                                        cart.removerCounter();
                                                        cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                                      },
                                                      child: Icon(Icons.delete))
                                                ],
                                              ),

                                              SizedBox(height: 5,),
                                              Text(snapshot.data![index].unitTag.toString() +" "+r"Rs"+ snapshot.data![index].productPrice.toString() ,
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(height: 5,),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: (){


                                                  },
                                                  child:  Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child:  Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: (){

                                                                int quantity =  snapshot.data![index].quantity! ;
                                                                int price = snapshot.data![index].initialPrice!;
                                                                quantity--;
                                                                int? newPrice = price * quantity ;

                                                                if(quantity > 0){
                                                                  dbHelper!.updateQuantity(
                                                                      Cart(
                                                                          id: snapshot.data![index].id!,
                                                                          productId: snapshot.data![index].id!.toString(),
                                                                          productName: snapshot.data![index].productName!,
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          productPrice: newPrice,
                                                                          quantity: quantity,
                                                                          unitTag: snapshot.data![index].unitTag.toString(),
                                                                          image: snapshot.data![index].image.toString())
                                                                  ).then((value){
                                                                    newPrice = 0 ;
                                                                    quantity = 0;
                                                                    cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                  }).onError((error, stackTrace){
                                                                    print(error.toString());
                                                                  });
                                                                }

                                                              },
                                                              child: Icon(Icons.remove , color: Colors.white,)),
                                                          Text( snapshot.data![index].quantity.toString(), style: TextStyle(color: Colors.white)),
                                                          InkWell(
                                                              onTap: (){
                                                                int quantity =  snapshot.data![index].quantity! ;
                                                                int price = snapshot.data![index].initialPrice!;
                                                                quantity++;
                                                                int? newPrice = price * quantity ;

                                                                dbHelper!.updateQuantity(
                                                                    Cart(
                                                                        id: snapshot.data![index].id!,
                                                                        productId: snapshot.data![index].id!.toString(),
                                                                        productName: snapshot.data![index].productName!,
                                                                        initialPrice: snapshot.data![index].initialPrice!,
                                                                        productPrice: newPrice,
                                                                        quantity: quantity,
                                                                        unitTag: snapshot.data![index].unitTag.toString(),
                                                                        image: snapshot.data![index].image.toString())
                                                                ).then((value){
                                                                  newPrice = 0 ;
                                                                  quantity = 0;
                                                                  cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                }).onError((error, stackTrace){
                                                                  print(error.toString());
                                                                });
                                                              },
                                                              child: Icon(Icons.add , color: Colors.white,)),

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
              return Text('') ;
            }),
            Consumer<CartProvider>(builder: (context, value, child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00" ? false : true,
                child: Column(
                  children: [
                    ReusableWidget(title: 'Sub Total', value: r'Rs'+value.getTotalPrice().toStringAsFixed(2),),
                    ReusableWidget(title: 'Discout 5%', value: r'Rs'+'20',),
                    ReusableWidget(title: 'Total', value: r'Rs'+value.getTotalPrice().toStringAsFixed(2),),
                    MaterialButton(onPressed: (){
 Navigator.of(context).push(PageTransition(
            child: Addressdetails(),
            type: PageTransitionType.bottomToTopPop,
            childCurrent: Container()));
                    },child: Container(child: Text("Order"),color: Colors.yellow,),)
                  ],
                ),
              );
            })
          ],
        ),
      ) ,
    );
  }
}



  





class ReusableWidget extends StatelessWidget {
  final String title , value ;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString() , style: Theme.of(context).textTheme.subtitle2,)
        ],
      ),
    );
  }
}







/** 

 Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.grey[800],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Let's order fresh items for you
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // list view of cart
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          leading: Image.network(
                            widget.product!.images![index],
                            height: 36,
                          ),
                          title: Text(
                            widget.product!.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            '\$',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: IconButton(
                              icon: const Icon(Icons.cancel), onPressed: () {}),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // total amount + pay now

            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(color: Colors.green[200]),
                        ),

                        const SizedBox(height: 8),
                        // total price
                        Text(
                          '\Rs',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // pay now
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child: const Payementpage(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                        },
                        child: Row(
                          children: const [
                            Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));*/