import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class DeliveryStatus extends StatefulWidget {
  const DeliveryStatus({super.key});

  @override
  State<DeliveryStatus> createState() => _DeliveryStatusState();
}

class _DeliveryStatusState extends State<DeliveryStatus> {
  final TextEditingController email = TextEditingController();
  final TextEditingController otp = TextEditingController();

  late EmailAuth emailAuth;

  void sendOtp() async {
    emailAuth.sessionName = "Test Session";
    var result =
        await emailAuth.sendOtp(recipientMail: email.value.text);
    if (result) {
      //   setState(() {
      //     submitValid = true;
      //   });
      // } else if (kDebugMode) {
      //   print("Error processing OTP requests, check server for logs");
      print("otp sent");
    }
  }

  void verifyOtp() {
    var result =
        emailAuth.validateOtp(recipientMail: email.text, userOtp: otp.text);
    if (result) {
      print("otp verified");
    } else {
      print("not verifed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: email,
            decoration: InputDecoration(
                hintText: "name",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter the name";
              }
              return null;
            },
            maxLines: 1,
          ),
          MaterialButton(onPressed: sendOtp,child: Text("send otp"),),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: otp,
            decoration: InputDecoration(
                hintText: "name",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter the name";
              }
              return null;
            },
            maxLines: 1,
          ),
           MaterialButton(onPressed: verifyOtp,child: Text("verify otp"),),
        ],
      ),
    );
  }
}
