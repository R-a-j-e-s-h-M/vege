
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBinaryOption extends StatefulWidget {
  CustomBinaryOption({
    Key? key,
    this.textLeft = "Left",
    this.textRight = "Right",
  }) : super(key: key);
  String textLeft;
  String textRight;

  @override
  State<CustomBinaryOption> createState() => _CustomBinaryOptionState();
}

class _CustomBinaryOptionState extends State<CustomBinaryOption> {
  bool lr = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  lr = false;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textLeft,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: lr == false ? const Color(0xFF2E3E5C) : const Color(0xFF9FA5C0)),
                  ),
                  Container(
                    height: lr == false ? 3 : 1,
                    color: lr == false ? const Color(0xFF1FCC79) :const  Color(0xFF9FA5C0),
                  ),
                ],
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  lr = true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textRight,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: lr == true ?const Color(0xFF2E3E5C) :const Color(0xFF9FA5C0)),
                  ),
                  Container(
                    height: lr == true ? 3 : 1,
                    color: lr == true ? const Color(0xFF1FCC79) :const Color(0xFF9FA5C0),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}