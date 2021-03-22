// Create a Form widget.
import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/presentation/images/wallpaper-galaxy.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center());
  }
}
