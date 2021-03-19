import 'package:flutter/material.dart';
import 'package:listz_app/presentation/screens/listz_screen.dart';
import 'package:listz_app/presentation/screens/items_screen.dart';
import 'package:listz_app/presentation/screens/login_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    ItemsScreenArguments args;

    if (settings.name == ItemsScreen.routeName) {
      args = settings.arguments;
    }

    switch (settings.name) {
      case '/listz':
        return MaterialPageRoute(
          builder: (_) => ListzScreen(),
        );
      case '/':
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
