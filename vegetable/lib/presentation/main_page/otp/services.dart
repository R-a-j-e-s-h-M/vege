


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vegetable/constant/colors.dart';
import 'package:vegetable/presentation/main_page/otp/model.dart';



class APIService {
 
  static var client = http.Client();

  static Future<LoginResponseModel> otpLogin(String mobileNo) async {
    
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(urr,"/users/otpLogin");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo}),
    );

    return loginResponseJson(response.body);
  }

  static Future<LoginResponseModel> verifyOtp(
    String mobileNo,
    String otpHash,
    String otpCode,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(urr,"/users/verifyOTP");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo, "otp": otpCode, "hash": otpHash}),
    );

    return loginResponseJson(response.body);
  }
}