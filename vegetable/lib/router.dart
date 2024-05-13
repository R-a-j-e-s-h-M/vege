import 'package:flutter/material.dart';
import 'package:vegetable/presentation/home/search.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings) {

  switch (routeSettings.name) {

 case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

   default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );

  }
}
