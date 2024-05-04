import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vegetable/presentation/farmerdetails/review/reviewmodel.dart';
import 'package:vegetable/presentation/farmerdetails/review/reviewservice.dart';
import 'package:vegetable/presentation/farmerui/homepage.dart';

class Reviews extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Reviews({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
  List<ReviewModal>? reviewList;

  static const kAccentColor = Color(0xFFF1F1F1);
  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kLightColor = Color(0xFF808080);

  final TextEditingController reviewcontroller = TextEditingController();
  final ReviewService service = ReviewService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallreviews();
  }

  void addReview() {
    service.addreview(context: context, reviewcontent: reviewcontroller.text,username: "rajesh",date: "12-23-44",rating: "5");
  }

  fetchallreviews() async {
   reviewList=await service.fetchAllReviews(context);
   setState(() {
     
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: "Reviews",
        child: DefaultBackButton(),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              color: kAccentColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "4.5",
                              style: TextStyle(fontSize: 48.0),
                            ),
                            TextSpan(
                              text: "/5",
                              style: TextStyle(
                                fontSize: 24.0,
                                color: kLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RatingBarIndicator(
                          rating: 2.5,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.red,
                              )),
                      const SizedBox(height: 16.0),
                      Text(
                        " Reviews",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                       MaterialButton(onPressed: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: 200,
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                    TextFormField(
                                      
                                      controller: reviewcontroller,
                                      decoration: InputDecoration(
                                          hintText: "enter the review",
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black38,
                                          )),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                            color: Colors.black38,
                                          ))),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "please enter the quantity";
                                        }
                                      },
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 10),
                                    MaterialButton(
                                      onPressed: addReview,
                                      child: const Text("add"),
                                    )
                                  ])));
                        });
                  })
                    ],
                  ),
                 
                  SizedBox(
                    width: 200.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              "${index + 1}",
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            const SizedBox(width: 4.0),
                            const Icon(Icons.star, color: Colors.orange),
                            const SizedBox(width: 8.0),
                            LinearPercentIndicator(
                              lineHeight: 6.0,
                              // linearStrokeCap: LinearStrokeCap.roundAll,
                              width: MediaQuery.of(context).size.width / 2.8,
                              animation: true,
                              animationDuration: 2500,
                              percent: ratings[index],
                              progressColor: Colors.orange,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
           reviewList==null?Loader(): Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                itemCount: reviewList!.length,
                itemBuilder: (context, index) {
                  return ReviewUI(
                    key: const Key("abcd"),
                    name: reviewList![index].username,
                    date: reviewList![index].date.substring(0,10),
                    comment: reviewList![index].reviewcontent,
                    rating: reviewList![index].rating,
                    onPressed: () => debugPrint("More Action $index"),
                    onTap: () => setState(() {
                      isMore = !isMore;
                    }),
                    isLess: isMore,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2.0,
                    color: kAccentColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewUI extends StatelessWidget {
  final String name, date, comment;
  final String rating;
  final Function onTap, onPressed;
  final bool isLess;
  const ReviewUI({
    required Key key,
    required this.name,
    required this.date,
    required this.comment,
    required this.rating,
    required this.onTap,
    required this.isLess,
    required this.onPressed,
  }) : super(key: key);
  static const kFixPadding = 16.0;
  static const kLightColor = Color(0xFF808080);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              RatingBarIndicator(
                  rating: 2.5,
                  itemCount: 5,
                  itemSize: 30.0,
                  itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.red,
                      )),
              const SizedBox(width: kFixPadding),
              Text(
                date,
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {},
            child: isLess
                ? Text(
                    comment,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  )
                : Text(
                    comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  // ignore: prefer_typing_uninitialized_variables
  final action;
  const DefaultAppBar({
    Key? key,
    required this.title,
    required this.child,
    this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    const kWhiteColor = Color(0xFFFFFFFF);
    const kRadius = 0.0;
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: kWhiteColor,
      elevation: kRadius,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: child,
      actions: action,
    );
  }
}

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
