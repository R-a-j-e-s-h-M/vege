import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/farmer/farmerauthservice.dart';

import 'package:vegetable/presentation/farmerdetails/review/reviewmodel.dart';

class ReviewService {
  // sign up user
  void addreview(
      {required BuildContext context,
      String? username,
      required String reviewcontent,
       String? date,
      String? rating}) async {
    try {
      ReviewModal user = ReviewModal(
        username: username!,
        rating: rating!,
        date: date!,
        reviewcontent: reviewcontent,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/add/review'),
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
            'Review added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<ReviewModal>> fetchAllReviews(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ReviewModal> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get/review'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              ReviewModal.fromJson(
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
