import 'package:flutter/material.dart';
import 'package:vegetable/presentation/farmerdetails/custombutton.dart';

// ignore: must_be_immutable
class ProfileTap extends StatelessWidget {
  String? name;
  ProfileTap({
    Key? key,
    this.showFollowBottomInProfile = false,
    required this.name,
  }) : super(key: key);
  bool showFollowBottomInProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Color(0xFF2E3E5C),
                ),
              ),
            ),
          ],
          leading: showFollowBottomInProfile == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF2E3E5C),
                      )),
                )
              : const SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/pngwing.com.png"),
                          ),
                          showFollowBottomInProfile == false
                              ? InkWell(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Color(0xFF1FCC79),
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                       Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: Text(name!,
                          style:const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                     const  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  
                             
                          Column(
                            children: [
                              Text(
                                "789",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Following",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      ),
                      showFollowBottomInProfile == true
                          ? CustomButton(onTap: () {}, text: "Follow")
                          : const SizedBox(
                              height: 20,
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ));
  }
}
