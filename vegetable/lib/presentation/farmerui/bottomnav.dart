import 'package:flutter/material.dart';


ValueNotifier<int> changevalue = ValueNotifier(0);

class Bottomnavigationone extends StatelessWidget {
  const Bottomnavigationone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: changevalue,
        builder: ((context, int newindex, child) => BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.collections), label: "Farmer"),
                
              
              ],
              currentIndex: newindex,
              onTap: (index) {
                changevalue.value = index;
              },
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme:const  IconThemeData(color: Colors.grey),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black.withOpacity(0.5),
            )));
  }
}
