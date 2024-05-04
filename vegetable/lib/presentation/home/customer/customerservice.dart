import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable/constant/colors.dart';

import 'package:vegetable/presentation/home/home.dart';

class CustomerService {
  

  // sign up user
  void signUpUsers(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String mobile,
      required String address,
      required String state,
      required String district,
      required String place,
    }) async {
    try {
      Customer user = Customer(
        id: '',
        name: name,
        email: email,
        password: password,
        mobile: mobile,
        address: address,
        state: state,
        district: district,
        place: place,
        type: '',
        token: '',
        cart:[],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup/customer'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin/customer'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<CustomerProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(PageTransition(
              child:const Home(),
              type: PageTransitionType.bottomToTopJoined,
              childCurrent: Container()));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all user data

  Future<List<Customer>> fetchAllcustomer(BuildContext context) async {
    final userProvider = Provider.of<CustomerProvider>(context, listen: false);
    List<Customer> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/customer'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Customer.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // get user data
  Future<List<Customer>> getUserData(
    BuildContext context,
  ) async {
    List<Customer> farmerlist = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/get/customer'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        httpErrorHandle(
          response: userRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(userRes.body).length; i++) {
              farmerlist.add(
                Customer.fromJson(
                  jsonEncode(
                    jsonDecode(userRes.body)[i],
                  ),
                ),
              );
            }
          },
        );

        var userProvider = Provider.of<CustomerProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return farmerlist;
  }
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      
      break;
    default:
      showSnackBar(context, response.body);
      
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class CustomerProvider extends ChangeNotifier {
  Customer _user = Customer(
    id: '',
    name: '',
    email: '',
    password: '',
    mobile: '',
    address: '',
    state: '',
    district: '',
    place: '',
  
    type: '',
    token: '',
    cart:[],
  );

  Customer get user => _user;

  void setUser(String user) {
    _user =Customer.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Customer user) {
    _user = user;
    notifyListeners();
  }
}

class Customer {
  final String id;
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String address;
  final String state;
  final String district;
  final String place;
  

  final String type;
  final String token;
  final List<dynamic> cart;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.address,
    required this.state,
    required this.district,
    required this.place,
  
    required this.type,
    required this.token,
     required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      "mobile": mobile,
      'address': address,
      "state": state,
      "district": district,
      "place": place,
    
      'type': type,
      'token': token,
      'cart':cart,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
      state: map['state'] ?? '',
      district: map['district'] ?? '',
      place: map['place'] ?? '',
    
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
    
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source));

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? mobile,
    String? address,
    String? state,
    String? district,
    String? place,
    
    String? type,
    String? token,
     List<dynamic>? cart,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      state: state ?? this.state,
      district: district ?? this.district,
      place: place ?? this.place,
      
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart?? this.cart
       
    );
  }
}
