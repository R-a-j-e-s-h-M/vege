import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/farmer/farmersignup.dart';
import 'package:vegetable/presentation/farmer/productmodel.dart';

import 'package:vegetable/presentation/farmer/vegetabledetails.dart';

class AuthService {
 

  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String mobile,
    required String address,
    required String state,
    required String district,
    required String place,
    required String village,
    
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        mobile: mobile,
        address: address,
        state: state,
        district: district,
        place: place,
        village: village,
        vegetable: [],
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
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
        Uri.parse('$uri/api/signin'),
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
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(PageTransition(
              child: Vegetabledetails(),
              type: PageTransitionType.bottomToTopJoined,
              childCurrent: Container()));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all user data

  Future<List<User>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/farmer'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              User.fromJson(
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
  Future<List<User>> getUserData(
    BuildContext context,
  ) async {
    List<User> farmerlist = [];
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
          Uri.parse('$uri/get/farmer'),
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
                User.fromJson(
                  jsonEncode(
                    jsonDecode(userRes.body)[i],
                  ),
                ),
              );
            }
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
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
      Navigator.of(context).push(PageTransition(
          child: const Farmersignup(),
          type: PageTransitionType.rightToLeftWithFade,
          childCurrent: Container()));
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      Navigator.of(context).push(PageTransition(
          child: const Farmersignup(),
          type: PageTransitionType.rightToLeftWithFade,
          childCurrent: Container()));
      break;
    default:
      showSnackBar(context, response.body);
      Navigator.of(context).push(PageTransition(
          child: const Farmersignup(),
          type: PageTransitionType.rightToLeftWithFade,
          childCurrent: Container()));
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    mobile: '',
    address: '',
    state: '',
    district: '',
    place: '',
    village: '',
    type: '',
    vegetable: [],
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String address;
  final String state;
  final String district;
  final String place;
  final String village;
  final List<Map<String,dynamic>>? vegetable;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.address,
    required this.state,
    required this.district,
    required this.place,
    required this.village,
    this.vegetable,
    required this.type,
    required this.token,
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
      "village": village,
      "vegetable":vegetable,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
      state: map['state'] ?? '',
      district: map['district'] ?? '',
      place: map['place'] ?? '',
      village: map['village'] ?? '',
      vegetable:  List<Map<String, dynamic>>.from(
        map['vegetable']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? mobile,
    String? address,
    String? state,
    String? district,
    String? place,
    String? village,
    List<Map<String,dynamic>>? vegetable,
    String? type,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      state: state ?? this.state,
      district: district ?? this.district,
      place: place ?? this.place,
      village: village ?? this.village,
      vegetable:vegetable?? this.vegetable,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }
}
