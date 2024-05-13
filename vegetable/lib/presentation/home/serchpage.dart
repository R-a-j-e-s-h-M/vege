import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmer/productmodel.dart';

import 'package:vegetable/presentation/home/card/card_widget.dart';

import 'package:vegetable/presentation/home/farmerexplore.dart';
import 'package:vegetable/presentation/home/search.dart';

import 'package:vegetable/presentation/services/searchservice.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  bool isLoading = false;
  List<User>? farmers;
  
  final AuthService authservice = AuthService();

  late List<String> autoCompleteData;

  late TextEditingController controller;

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData =
        await rootBundle.loadString("assets/farmers.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
    fetchfarmerdetails();
  }

  fetchfarmerdetails() async {
    farmers = await authservice.fetchAllProducts(context);
    setState(() {});
  }

  // fetchSearchedProduct() async {
  //   farmers = await searchServices.fetchSearchedProduct(
  //       context: context, searchQuery: controller.text);
  //   setState(() {});
  // }
  void onscreenpage(String query) {
    Navigator.of(context).push(PageTransition(
        child: Searchpage(),
        type: PageTransitionType.rightToLeftWithFade,
        childCurrent: Container()));
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToSearch(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Search the farmer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Container(
                      width: 300,
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
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 270,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Autocomplete(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<String>.empty();
                                      } else {
                                        return autoCompleteData.where((word) =>
                                            word.toLowerCase().contains(
                                                textEditingValue.text
                                                    .toLowerCase()));
                                      }
                                    },
                                    optionsViewBuilder: (context,
                                        Function(String) onSelected, options) {
                                      return Material(
                                        elevation: 4,
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final option =
                                                options.elementAt(index);

                                            return ListTile(
                                              // title: Text(option.toString()),
                                              title: SubstringHighlight(
                                                text: option.toString(),
                                                term: controller.text,
                                                textStyleHighlight:
                                                    const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              subtitle: const Text(
                                                  "Chengannur alapuzha"),
                                              onTap: () {
                                                onSelected(option.toString());
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemCount: options.length,
                                        ),
                                      );
                                    },
                                    onSelected: (selectedString) {
                                      debugPrint(selectedString);
                                    },
                                    fieldViewBuilder: (context, controller,
                                        focusNode, onEditingComplete) {
                                      this.controller = controller;

                                      return TextField(
                                        onSubmitted: navigateToSearchScreen,
                                        focusNode: focusNode,
                                        onEditingComplete: onEditingComplete,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            hintText: "Search the farmer",
                                            prefixIcon: const Icon(
                                              Icons.search,
                                              size: 20,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.cancel_sharp,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                controller.clear();
                                              },
                                            )),
                                      );
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                    onPressed: () {
                      setState(() {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) => Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 500,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const CustomCategoriesList(),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: MaterialButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  color: Colors.black,
                                                  child: const Text(
                                                    "cancel",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                      });
                    },
                    icon: const Icon(
                      Icons.tune,
                      color: Colors.black,
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Or"),
              TextField(
                onSubmitted: navigateToSearch,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: "search the place",
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel_sharp,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        controller.clear();
                      },
                    )),
              ),
              // Search Suggestions
              Container(
                width: 600,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Search Suggestions",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        searchSuggestionsTiem("farmer name"),
                        searchSuggestionsTiem("place"),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        searchSuggestionsTiem("district"),
                        searchSuggestionsTiem("village"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Farmers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Column(
                        children: [
                          farmers == null
                              ? Loader()
                              : SizedBox(
                                  height: 1500,
                                  child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                          products == null
                              ? const Loader()
                              : Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: products!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                            User  farmer = farmers![index];
                                              Navigator.of(context).push(
                                                  PageTransition(
                                                      child: CardWidget(
                                                        farmer:farmer
                                                      ),
                                                      type: PageTransitionType
                                                          .rightToLeftWithFade,
                                                      childCurrent:
                                                          Container()));
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

searchSuggestionsTiem(String text) {
  const Color mainText = Color(0xFF2E3E5C);

  const Color form = Color(0xFFF4F5F7);
  return Container(
    margin: const EdgeInsets.only(left: 8),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration:
        BoxDecoration(color: form, borderRadius: BorderRadius.circular(30)),
    child: Text(
      text,
      style: const TextStyle(color: mainText),
    ),
  );
}

class CustomCategoriesList extends StatefulWidget {
  const CustomCategoriesList({Key? key}) : super(key: key);

  @override
  State<CustomCategoriesList> createState() => _CustomCategoriesListState();
}

class _CustomCategoriesListState extends State<CustomCategoriesList> {
  void navigateToSearchScree(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToSearchScre(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF1FCC79);

    const Color secondaryText = Color(0xFF9FA5C0);

    const Color form = Color(0xFFF4F5F7);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Filter",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Row(
          children: [
            menuButton(
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                },
                color: _index == 0 ? primary : form,
                text: "All",
                textColor: _index == 0 ? Colors.white : secondaryText,
                width: _index == 0 ? 65 : 85),
            menuButton(
                onTap: () {
                  setState(() {
                    _index = 1;
                    navigateToSearchScree("alapuzha");
                  });
                },
                color: _index == 1 ? primary : form,
                text: "Alapuzha",
                textColor: _index == 1 ? Colors.white : secondaryText,
                width: _index == 1 ? 65 : 85),
            menuButton(
                onTap: () {
                  setState(() {
                    _index = 2;
                    navigateToSearchScre("chengannur");
                  });
                },
                color: _index == 2 ? primary : form,
                text: "village chengannur",
                textColor: _index == 2 ? Colors.white : secondaryText,
                width: _index == 2 ? 65 : 85),
          ],
        ),
      ],
    );
  }

  menuButton(
      {required String text,
      required Color color,
      required Color textColor,
      required double width,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
