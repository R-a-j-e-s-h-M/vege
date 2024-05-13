
















import 'package:flutter/material.dart';

import 'package:auth_email/auth_email.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/deliveryboy/deliverystatus.dart';

final authEmail = AuthEmail(
  appName: 'Auth Email Example',
  server: 'https://pub.lamnhan.dev/auth-email/api',
  serverKey: 'ohYwh',
  isDebug: true,
);


class AuthEmailAp extends StatefulWidget {
  const AuthEmailAp({Key? key}) : super(key: key);

  @override
  State<AuthEmailAp> createState() => _AuthEmailApState();
}

class _AuthEmailApState extends State<AuthEmailAp> {
  String sendOtpButton = 'Send OTP';
  String verifyOtpButton = 'Verify OTP';

  bool isSent = false;
  String desEmailTextField = '';
  String verifyTextField = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Otp verification'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isSent) ...[
            const Text('enter your mail id:'),
            TextFormField(
              textAlign: TextAlign.center,
              initialValue: desEmailTextField,
              onChanged: (value) {
                desEmailTextField = value;
              },
              validator: (value) {
                if (!AuthEmail.isValidEmail(desEmailTextField)) {
                  return 'This email is not valid!';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  sendOtpButton = 'Sending OTP...';
                });

                final result =
                    await authEmail.sendOTP(email: desEmailTextField);

                if (!result) {
                  setState(() {
                    sendOtpButton = 'Send OTP failed!';
                  });
                }
                setState(() {
                  isSent = result;
                });
              },
              child: Text(sendOtpButton),
            )
          ] else ...[
            const Text('enter your OTP:'),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                verifyTextField = value;
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final result = authEmail.verifyOTP(
                    email: desEmailTextField, otp: verifyTextField);

                if (result) {
                  setState(() {
                    verifyOtpButton = 'Verified OTP';
                     Navigator.of(context).push(PageTransition(
                              child:  DeliveryStatus(),
                              type: PageTransitionType.bottomToTopJoined,
                              childCurrent: Container()));
                    
                  });
                } else {
                  setState(() {
                    verifyOtpButton = 'Verify OTP failed!';
                  });
                }
              },
              child: Text(verifyOtpButton),
            )
          ]
        ],
      ),
    );
  }
}