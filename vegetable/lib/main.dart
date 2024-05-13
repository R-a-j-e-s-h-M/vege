import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/cart/address/addressservice.dart';
import 'package:vegetable/presentation/cart/cartprovider.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/farmer/productmodel.dart';
import 'package:vegetable/presentation/farmerdetails/farmerprovider.dart';
import 'package:vegetable/presentation/home/customer/customerservice.dart';
import 'package:vegetable/presentation/home/vegetablelisting.dart';
import 'package:vegetable/presentation/main_page/onboardingpage/onbaording_screen.dart';
import 'package:vegetable/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    
  
    ),
    
    
    ChangeNotifierProvider(create: (context) => FarmerProvider()),
   
    ChangeNotifierProvider(create: (context) => CustomerProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => AddressProvider()),
    
  ],
   child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    authService.fetchAllProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldbackgroundcolor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Onboardingscreen(),
       onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
