import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/presentation/farmerdetails/farmerdb.dart';
import 'package:vegetable/presentation/farmerdetails/farmermodel.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmerdetails/farmerprovider.dart';
import 'package:vegetable/presentation/home/appbannerlist.dart';
import 'package:vegetable/presentation/home/banneritem.dart';
import 'package:vegetable/presentation/home/card/card_widget.dart';
import 'package:vegetable/presentation/home/customappbar/customappbar.dart';
import 'package:vegetable/presentation/home/indicator.dart';
import 'package:vegetable/presentation/home/search.dart';
import 'package:vegetable/presentation/home/serchpage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/home/vegetablelisting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User>? farmers;
  final AuthService authservice = AuthService();

  var _selectedindex = 0;

  int current = 0;

  @override
  void initState() {
    super.initState();
    fetchfarmerdetails();
  }

  fetchfarmerdetails() async {
    farmers = await authservice.fetchAllProducts(context);
    setState(() {});
  }

  DB db = DB();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<FarmerProvider>(context);
    return Scaffold(
      body: ListView(children: [
        const Appbarwidget(),
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: Searchpage(),
                      type: PageTransitionType.rightToLeftWithFade,
                      childCurrent: Container()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                                child: Text(
                              "seatch the nearest farmer",
                              textAlign: TextAlign.center,
                            ))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 200,
            decoration: const BoxDecoration(),
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedindex = index;
                });
              },
              controller: PageController(viewportFraction: 0.7),
              itemBuilder: (context, index) {
                return Banneritem(
                  appbanner: appbannerlist[index],
                );
              },
              itemCount: appbannerlist.length,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                appbannerlist.length,
                (index) => Indicator(
                    isactive: _selectedindex == index ? true : false)),
          ],
        ),
        const SizedBox(height: 10),
        const VegetableListing(),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "Farmer",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        farmers == null
            ? const Loader()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4000,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final farmer = farmers![index];
                             
                              return CardWidget(
                                farmer: farmer,
                                index:index,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(height: 10),
                            itemCount: farmers!.length),
                      ),
                    ],
                  ),
                )),
      ]),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
