// Create a Form widget.
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/presentation/images/wallpaper-galaxy.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(),
    );
  }
}
