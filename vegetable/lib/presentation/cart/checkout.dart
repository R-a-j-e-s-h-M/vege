



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';






class CheckoutOnePage extends StatelessWidget {


  const CheckoutOnePage({super.key});
  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              "Choose your payment method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0),
         
            
            const RoundedContainer(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.googleWallet,
                  color: Colors.indigo,
                ),
                title: Text("Google Pay"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const RoundedContainer(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.applePay,
                  color: Colors.indigo,
                ),
                title: Text("Apple Pay"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
             const RoundedContainer(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.applePay,
                  color: Colors.indigo,
                ),
                title: Text("Netbanking"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
             const RoundedContainer(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.applePay,
                  color: Colors.indigo,
                ),
                title: Text("Cash on delivery"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
             const RoundedContainer(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.applePay,
                  color: Colors.indigo,
                ),
                title: Text("Debit card"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.all(24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Continue"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}


class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius,
    this.alignment,
    this.elevation,
  }) : super(key: key);
  final Widget child;
  final double? width;
  final double? height;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      color: color,
      elevation: elevation ?? 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}