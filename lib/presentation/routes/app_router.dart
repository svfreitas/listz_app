import 'package:flutter/material.dart';
import 'package:listz_app/presentation/screens/signup_screen.dart';
import '../screens/listz_screen.dart';
import '../screens/items_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    ItemsScreenArguments? args;

    if (settings.name == ItemsScreen.routeName) {
      args = settings.arguments as ItemsScreenArguments?;
    }

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
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
          builder: (_) => ItemsScreen(args!.listName),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      default:
        return null;
    }
  }
}
