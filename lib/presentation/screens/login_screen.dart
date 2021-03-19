// Create a Form widget.

import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:listz_app/logic/bloc/login/login_bloc.dart';
import 'package:listz_app/core/env.dart';
import 'package:listz_app/core/global.dart';
import 'package:listz_app/presentation/screens/listz_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Entre com sua conta"),
        centerTitle: true,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, ListzScreen.routeName);
        } else if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is LoginInitial) {
          return buildForm(_formKey, context);
        } else if (state is LoginLoading) {
          return buildLoading();
        } else {
          return buildForm(_formKey, context);
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text("Conta"), icon: Icon(Icons.account_box)),
          BottomNavigationBarItem(
              title: Text(
                "Listas",
                // style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              icon: Icon(Icons.apps)),
          BottomNavigationBarItem(
              title: Text(
                "Configuração",
                //        style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}

Widget buildForm(GlobalKey<FormState> _formKey, BuildContext context) {
  String username, password;
  return Form(
    key: _formKey,
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/presentation/images/wallpaper-galaxy.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Conta',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Forneça a conta';
                    }
                    username = value;
                    return null;
                  },
                  initialValue: '',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Senha',
                    icon: Icon(Icons.security_rounded),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Forneça a senha';
                    }
                    password = value;
                    return null;
                  },
                  initialValue: '',
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            LoginBloc loginBloc = context.read<LoginBloc>();
                            loginBloc.add(
                                LogIn(username: username, password: password));
                          }
                        },
                        child: Center(child: Text('Entrar')),
                      ),
                      OutlineButton(
                        color: Colors.transparent,
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            LoginBloc loginBloc = context.read<LoginBloc>();
                            loginBloc.add(
                                LogIn(username: username, password: password));
                          }
                        },
                        child: Center(child: Text('Cadastrar')),
                      ),
                    ],
                  ),
                ),
              ])),
    ),
  );
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
