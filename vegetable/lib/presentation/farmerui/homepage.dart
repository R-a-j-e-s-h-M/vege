import 'package:flutter/material.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmer/vegetabledetails.dart';
import 'package:vegetable/presentation/farmerui/card.dart';






class Homeone extends StatefulWidget {
  
  const Homeone({super.key});

  @override
  State<Homeone> createState() => _HomeState();
}

class _HomeState extends State<Homeone> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView(children: [
        
        
        const SizedBox(height: 10),

       const SizedBox(
          height: 10
  
        ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: const  Text("Farmer",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
      ),
        const SizedBox(
          height: 10,
        ),
      farmers==null?const Loader():  Padding(
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

                          return CardWidgetone(
                            farmer: farmer,
                            
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