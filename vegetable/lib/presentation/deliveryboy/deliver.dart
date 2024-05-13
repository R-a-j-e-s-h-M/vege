import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/farmerdetails/farmerdb.dart';
import 'package:vegetable/presentation/farmerdetails/farmermodel.dart';
import 'package:vegetable/presentation/farmerdetails/farmerprovider.dart';
import 'package:vegetable/presentation/farmerui/homepage.dart';

class Deliver extends StatefulWidget {
  const Deliver({super.key});

  @override
  State<Deliver> createState() => _DeliverState();
}

DB db = DB();

class _DeliverState extends State<Deliver> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<FarmerProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Farmer>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                  } else {
                    return snapshot.data == null
                        ? Loader()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(children: [
                                                      Text(snapshot
                                                          .data![index].address
                                                          .toString()),
                                                      Text(snapshot
                                                          .data![index].phone
                                                          .toString()),
                                                      Text(snapshot
                                                          .data![index].name
                                                          .toString()),
                                                    ]),
                                                    InkWell(
                                                        onTap: () {
                                                          db.delete(snapshot
                                                              .data![index]
                                                              .id!);
                                                          
                                                        },
                                                        child:
                                                            Icon(Icons.delete))
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ])));
                                }));
                  }
                }
                return Text('');
              }),
        ]),
      ),
    );
  }
}
