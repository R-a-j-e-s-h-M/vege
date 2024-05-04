import 'package:flutter/material.dart';


class ImageAndText extends StatelessWidget {
  const ImageAndText({Key? key, required this.image, required this.text})
      : super(key: key);
  final String image;
  final String text;
  static const Color lightBlue = Color(0xFF4C9EEB);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 110,
            height: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(image)))),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(color: lightBlue),
        )
      ],
    );
  }
}