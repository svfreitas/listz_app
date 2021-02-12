import 'package:flutter/material.dart';
import 'package:listz_app/presentation/screens/home_screen.dart';
import 'package:listz_app/presentation/screens/items_screen.dart';
import 'package:listz_app/presentation/screens/login_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    ItemsScreenArguments args;

    if (settings.name == ItemsScreen.routeName) {
      args = settings.arguments;
    }

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/items':
        return MaterialPageRoute(
          builder: (_) => ItemsScreen(args.listName),
        );
      default:
        return null;
    }
  }
}
