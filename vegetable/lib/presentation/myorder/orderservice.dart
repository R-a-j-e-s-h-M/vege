
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';
import 'package:vegetable/presentation/myorder/ordermodel.dart';




class Orderdeliveredservice {
  // sign up user
  void adddelivered(
      {required BuildContext context,
      required String orderdelivered,
    
     }) async {
    try {
    Orderdelivered user = Orderdelivered(
        orderdelivered: orderdelivered,
        
      );

      http.Response res = await http.post(
        Uri.parse('$uri/add/orderdelivered'),
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
            'orderdelivered added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Orderdelivered>> fetchAlldelivered(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Orderdelivered> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/orderdelivered'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Orderdelivered.fromJson(
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




class Orderpackedservice {
  // sign up user
  void addpacked(
    
      {required BuildContext context,
      required String orderpacked,
    
     }) async {
    try {
    Orderpacked user = Orderpacked(
        orderpacked: orderpacked,
        
      );

      http.Response res = await http.post(
        Uri.parse('$uri/add/orderpacked'),
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
            'orderpacked added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Orderpacked>> fetchAllpacked(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Orderpacked> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/orderpacked'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Orderpacked.fromJson(
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



class Orderdispatchedservice {
  // sign up user
  void adddispatched(
      {required BuildContext context,
      required String orderdispatched,
    
     }) async {
    try {
    Orderdispatched user = Orderdispatched(
        orderdispatched: orderdispatched,
        
      );

      http.Response res = await http.post(
        Uri.parse('$uri/add/orderdispatched'),
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
            'orderdispatched added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Orderdispatched>> fetchAlldispatched(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Orderdispatched> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/orderdispatched'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Orderdispatched.fromJson(
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


class Orderplacedservice {
  // sign up user
  void addplaced(
      {required BuildContext context,
      required String orderplaced,
    
     }) async {
    try {
    Orderplaced user = Orderplaced(
        orderplaced: orderplaced,
        
      );

      http.Response res = await http.post(
        Uri.parse('$uri/add/orderplaced'),
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
            'orderplaced added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Orderplaced>> fetchplaced(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Orderplaced> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/orderplaced'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Orderplaced.fromJson(
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



