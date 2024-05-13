import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmer/productmodel.dart';
import 'package:vegetable/presentation/farmerdetails/farmer_detail.dart';
import 'package:vegetable/presentation/farmerui/farmerdetailone.dart';
import 'package:vegetable/presentation/farmerui/homepage.dart';
import 'package:vegetable/presentation/home/searchedproduct.dart';
import 'package:vegetable/presentation/services/searchservice.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<User>? farmers;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
    fetchsearchedproduc();
    fetchsearchedprodu();
    fetchsearchedprod();
  }

  fetchSearchedProduct() async {
    farmers = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  fetchsearchedproduc() async {
    farmers = await searchServices.fetchSearchedProduc(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  fetchsearchedprodu() async {
    farmers = await searchServices.fetchSearchedProdu(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }


  
  fetchsearchedprod() async {
    farmers = await searchServices.fetchSearchedProd(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 237, 241, 241),
                  Color.fromARGB(255, 248, 254, 254),
                ],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
             
            ],
          ),
        ),
      ),
      body: farmers == null
          ? const Loader()
          : Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: farmers!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          final farmer = farmers![index];
                          Navigator.of(context).push(PageTransition(
                              child: Farmers(
                                farmers: farmer.name,
                                district: farmer.district,
                                address: farmer.address,
                                phone: farmer.mobile,
                              ),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                        },
                        child: SearchedProduct(
                          product: farmers![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
