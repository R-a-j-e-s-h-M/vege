import 'package:flutter/material.dart';







class Indicator extends StatelessWidget {
  final bool? isactive;
  const Indicator({
    super.key,
    required this.isactive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isactive! ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isactive! ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
