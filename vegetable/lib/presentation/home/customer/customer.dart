import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vegetable/presentation/home/customer/customerservice.dart';
import 'package:vegetable/presentation/home/home.dart';
import 'package:vegetable/presentation/main_page/bottomnavbar/screenmainpage.dart';

class Customerform extends StatefulWidget {
  const Customerform({super.key});

  @override
  State<Customerform> createState() => _CustomerformState();
}

enum Auth {
  signin,
  signup,
}

class _CustomerformState extends State<Customerform> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  CustomerService customer = CustomerService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    stateController.dispose();
    districtController.dispose();
    placeController.dispose();

  }

  void signUpUsers() {
    customer.signUpUsers(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      mobile: mobileController.text,
      address: addressController.text,
      state: stateController.text,
      district: districtController.text,
      place: placeController.text,
      
    );
  }

  void signInUser() {
    customer.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    Navigator.of(context).push(PageTransition(
        child: const Home(),
        type: PageTransitionType.rightToLeftWithFade,
        childCurrent: Container()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? Colors.white
                      : const Color(0xffebecee),
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: const Color.fromRGBO(235, 207, 29, 1),
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                         TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _nameController,
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
                          const SizedBox(height: 10),
                          TextFormField(
                            
                            controller: _emailController,
                            decoration: InputDecoration(
                                hintText: "email",
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black38,
                                )),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black38,
                                ))),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "please enter the email";
                              }
                               else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(val)) {
      return 'Please enter a valid email address';
    }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                hintText: "password",
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black38,
                                )),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black38,
                                ))),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "please enter the password";
                              }
                              if (val.length < 8) {
                                return "password should contain 8 characters ";
                              }
                               if (!val.contains(RegExp(r'[A-Z]'))) {
                                 return '• Uppercase letter is missing';
    }
    // Contains at least one lowercase letter
    if (!val.contains(RegExp(r'[a-z]'))) {
      return '• Lowercase letter is missing.';
    }
    // Contains at least one digit
    if (!val.contains(RegExp(r'[0-9]'))) {
       return '• Digit is missing.';
    }
    // Contains at least one special character
    if (!val.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return '• Special character is missing.\n';
    }
                              
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: mobileController,
                            decoration: InputDecoration(
                                hintText: "mobile",
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
                                return "please enter the mobile";
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: addressController,
                            decoration: InputDecoration(
                                hintText: "address",
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
                                return "please enter the address";
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: stateController,
                            decoration: InputDecoration(
                                hintText: "state",
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
                                return "please enter the state";
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: districtController,
                            decoration: InputDecoration(
                                hintText: "district",
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
                                return "please enter the district";
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: placeController,
                            decoration: InputDecoration(
                                hintText: "place",
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
                                return "please enter the place";
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUsers();
                              }
                            },
                          )
                          
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? Colors.white
                      : const Color(0xffebecee),
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: const Color.fromRGBO(235, 207, 29, 1),
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                         TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            decoration: InputDecoration(
                                hintText: "email",
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
                                return "please enter the email";
                              }
                              else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(val)) {
      return 'Please enter a valid email address';
    }
                              
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                hintText: "password",
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(96, 53, 53, 53),
                                )),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black38,
                                ))),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "please enter the password";
                              }
                                if (val.length < 7) {
                                return "password should contain 8 characters ";
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Sign In',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.orange : Colors.black,
        ),
      ),
    );
  }
}
