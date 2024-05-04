




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/cart/address/addressmodel.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';









class AddressService {
  // sign up user
  void addaddress(
      {required BuildContext context,
      required String address,
      required String phonenumber,
       required String landmark,
     }) async {
    try {
    Addressmodel user = Addressmodel(
        address: address,
        phonenumber: phonenumber,
        landmark: landmark,
      
      );

      http.Response res = await http.post(
        Uri.parse('$uri/add/address'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'address added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Addressmodel>> fetchAlladdress(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Addressmodel> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/address'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

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
}




class AddressProvider extends ChangeNotifier {
  Addressmodel _user = Addressmodel(
      
      address: '',
      landmark: '',
      phonenumber: '',
      );

  Addressmodel get user => _user;

  void setUser(String user) {
    _user = Addressmodel.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Addressmodel user) {
    _user = user;
    notifyListeners();
  }
}
