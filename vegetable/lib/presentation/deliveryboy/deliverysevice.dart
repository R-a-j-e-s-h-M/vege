import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/cart/address/addressmodel.dart';
import 'package:vegetable/presentation/cart/address/addressservice.dart';
import 'package:vegetable/presentation/deliveryboy/deliverpage.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';

import 'package:vegetable/presentation/home/home.dart';

class DeliveryService {



  Future<List<Addressmodel>> fetchaddress({
    required BuildContext context,
    required String id,
  }) async {
     final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Addressmodel> productList = [];
    try {
       
      http.Response res = await http.get(
        Uri.parse('$uri/delivery/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
            Addressmodel.fromJson(
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
  // sign up user
  void signUpUsertwo(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String mobile,
      required String address,
      required String state,
      required String district,
      required String place,
      required String license,
      required String vechicle}) async {
    try {
      Delivery user = Delivery(
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
        license: license,
        vechicle: vechicle,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup/delivery'),
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
  void signInUsertwo({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin/delivery'),
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
          Provider.of<DeliveryProvider>(context, listen: false)
              .setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(PageTransition(
              child: const Home(),
              type: PageTransitionType.bottomToTopJoined,
              childCurrent: Container()));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all user data

  Future<List<Delivery>> fetchAllcustomer(BuildContext context) async {
    final userProvider = Provider.of<DeliveryProvider>(context, listen: false);
    List<Delivery> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/delivery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Delivery.fromJson(
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
  Future<List<Delivery>> getUserData(
    BuildContext context,
  ) async {
    List<Delivery> farmerlist = [];
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
          Uri.parse('$uri/get/delivery'),
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
                Delivery.fromJson(
                  jsonEncode(
                    jsonDecode(userRes.body)[i],
                  ),
                ),
              );
            }
          },
        );

        var userProvider =
            Provider.of<DeliveryProvider>(context, listen: false);
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
      Navigator.of(context).push(PageTransition(
          child:  Deliverypage(),
          type: PageTransitionType.rightToLeftWithFade,
          childCurrent: Container()));
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

class DeliveryProvider extends ChangeNotifier {
  Delivery _user = Delivery(
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
      license: " ",
      vechicle: " ");

  Delivery get user => _user;

  void setUser(String user) {
    _user = Delivery.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Delivery user) {
    _user = user;
    notifyListeners();
  }
}

class Delivery {
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
  final String license;
  final String vechicle;

  Delivery({
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
    required this.license,
    required this.vechicle
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
     'license':license,
     'vechicle':vechicle
    };
  }

  factory Delivery.fromMap(Map<String, dynamic> map) {
    return Delivery(
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
      license: map["license"]?? '',
      vechicle :map['vechicle']??'',    );
  }

  String toJson() => json.encode(toMap());

  factory Delivery.fromJson(String source) =>
      Delivery.fromMap(json.decode(source));

  Delivery copyWith({
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
    String? license,
    String? vechicle
  }) {
    return Delivery(
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
        license: license??this.license,
        vechicle: vechicle??this.vechicle
        );
  }
}
