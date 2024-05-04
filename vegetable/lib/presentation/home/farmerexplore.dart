import 'package:flutter/material.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/home/card/card_widget.dart';
import 'package:vegetable/presentation/services/categoryservice.dart';

// ignore: must_be_immutable
class Farmerexplore extends StatefulWidget {
  String category;
  Farmerexplore({super.key, required this.category});

  @override
  State<Farmerexplore> createState() => _FarmerexploreState();
}

class _FarmerexploreState extends State<Farmerexplore> {
  List<User>? farmers;
  final HomeServices homeServices = HomeServices();
  final AuthService authservice = AuthService();

  @override
  void initState() {
    super.initState();
    // fetchCategoryProducts();
    fetchfarmerdetails();
  }

  /* fetchCategoryProducts() async {
    farmers = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }
  */

  fetchfarmerdetails() async {
    farmers = await authservice.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            height: 3000,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Farmers to explore",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Column(
                    children: [
                      farmers == null
                          ? Loader()
                          : SizedBox(
                              height: 1500,
                              child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final farmer = farmers![index];

                                    return CardWidget(
                                      farmer: farmer,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 10),
                                  itemCount: farmers!.length),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
