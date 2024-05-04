import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:substring_highlight/substring_highlight.dart';
import 'package:vegetable/presentation/farmer/farmeradminservice.dart';

import 'package:vegetable/presentation/farmer/productmodel.dart';
import 'package:vegetable/presentation/home/farmerexplore.dart';

class Vegetabledetails extends StatefulWidget {
  const Vegetabledetails({super.key});

  @override
  State<Vegetabledetails> createState() => _VegetabledetailsState();
}

class _VegetabledetailsState extends State<Vegetabledetails> {
  bool isLoading = false;

  late List<String> autoCompleteData;

  late TextEditingController controller = TextEditingController();
  late TextEditingController controller1 = TextEditingController();
  late TextEditingController quantitycontroller = TextEditingController();
  late TextEditingController pricecontroller = TextEditingController();
  late TextEditingController emailcontroller = TextEditingController();
  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  String category = 'Vegetable';

  final _addProductFormKey = GlobalKey<FormState>();

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData =
        await rootBundle.loadString("assets/vegetables.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  List<File> images = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProductss(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: controller1.text,
          price: double.parse(pricecontroller.text),
          quantity: double.parse(quantitycontroller.text),
          category: category,
          images: images,
          email: emailcontroller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(right: 18.0, top: 40),
          child: ListView(
            children: [
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        } else {
                          return autoCompleteData.where((word) => word
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        }
                      },
                      optionsViewBuilder:
                          (context, Function(String) onSelected, options) {
                        return Material(
                          elevation: 4,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);

                              return ListTile(
                                // title: Text(option.toString()),
                                title: SubstringHighlight(
                                  text: option.toString(),
                                  term: controller.text,
                                  textStyleHighlight: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: const Text("This is subtitle"),
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
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        this.controller = controller;

                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            hintText: "Search Vegetable",
                            prefixIcon: const Icon(Icons.search),
                          ),
                        );
                      },
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "OR",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Form(
                    key: _addProductFormKey,
                    child: TextField(
                      onChanged: ((value) {
                        setState(() {
                          value = controller1.text;
                        });
                      }),
                      controller: controller1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.yellow[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.yellow[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.yellow[300]!),
                          ),
                          hintText: "Add vegetable",
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller1.clear();
                              },
                              icon: const Icon(Icons.cancel_sharp))),
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: ((value) {
                  setState(() {
                    value = controller1.text;
                  });
                }),
                controller: quantitycontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    hintText: "Add quantity in kilograms",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller1.clear();
                        },
                        icon: const Icon(Icons.cancel_sharp))),
              ),
              TextField(
                keyboardType:TextInputType.number ,
                onChanged: ((value) {
                  setState(() {
                    value = controller1.text;
                  });
                }),
                controller: pricecontroller,
               
                decoration: InputDecoration(
                  
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    hintText: "Add price per kilogram",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller1.clear();
                        },
                        icon: const Icon(Icons.cancel_sharp))),
              ),
              TextField(
                onChanged: ((value) {
                  setState(() {
                    value = controller1.text;
                  });
                }),
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.yellow[300]!),
                    ),
                    hintText: "enter email",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller1.clear();
                        },
                        icon: const Icon(Icons.cancel_sharp))),
              ),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 150,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Select Product Images',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              MaterialButton(
                onPressed: () {
                  sellProduct();
                },
                child: const Text("ADD"),
              ),
              const SizedBox(
                height: 20,
              ),
              products == null
                  ? const Loader()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3000,
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final vegetable = products![index];
                                  return CardWidget(
                                    vegetable: vegetable,
                                    oppressed: () {
                                      deleteProduct(vegetable, index);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 5,
                                  );
                                },
                                itemCount: products!.length),
                          ),
                        ],
                      ),
                    )
            ],
          )),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Product vegetable;
  final VoidCallback? oppressed;

  const CardWidget(
      {super.key, required this.vegetable, required this.oppressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(vegetable.images![0]))),
              child: const Center(
                child: Text("u"),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  vegetable.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Quantit/gram:${vegetable.quantity}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Price/kg:${vegetable.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
                IconButton(onPressed: oppressed, icon: const Icon(Icons.delete))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
