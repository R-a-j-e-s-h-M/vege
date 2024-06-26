import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:vegetable/presentation/main_page/otp/services.dart';
import 'package:vegetable/presentation/main_page/otp/verify.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mobileNumber = '';
  bool enableBtn = false;
  bool isAPIcallProcess = false;

  @override
  void initState() {
    super.initState();
    mobileNumber = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: loginUI(),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget loginUI() {
    final signUpFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: signUpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://i.imgur.com/bOCEVJg.png",
              height: 180,
              fit: BoxFit.contain,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  "Login with a Mobile Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Enter your mobile number we will send you OTP to verify",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: 47,
                      width: 50,
                      margin: const EdgeInsets.fromLTRB(0, 10, 3, 32),
                      //padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "+91",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      maxLines: 1,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(6),
                        hintText: "Mobile Number",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        if (value.length > 9) {
                          mobileNumber = value;
                          enableBtn = true;
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter mobile number";
                        }
                        if (value!.length < 10) {
                          return "enter valid mobile number";
                        }
                        
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: FormHelper.submitButton(
                "Continue",
                () async {
                  signUpFormKey.currentState!.validate();
                  if (enableBtn && mobileNumber.length > 8) {
                    setState(() {
                      isAPIcallProcess = true;
                    });

                    APIService.otpLogin(mobileNumber).then((response) async {
                      setState(() {
                        isAPIcallProcess = false;
                      });
                      print(response.message);
                      print(response.data);
                      if (response.data != null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPVerifyPage(
                              otpHash: response.data,
                              mobileNo: mobileNumber,
                            ),
                          ),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                btnColor: Colors.black,
                borderColor: HexColor("#78D0B1"),
                txtColor: Colors.yellow,
                borderRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
