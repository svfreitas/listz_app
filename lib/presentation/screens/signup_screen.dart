// Create a Form widget.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/signup/signup_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/signup";

  @override
  SignUpScreenState createState() {
    return SignUpScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? username, password, email;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Crie  sua conta"),
        centerTitle: true,
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is SignUpInitial) {
          return buildForm(_formKey, context);
        } else if (state is SignUpLoading) {
          return buildLoading();
        } else {
          return buildForm(_formKey, context);
        }
      }),
    );
  }
}

Widget buildForm(GlobalKey<FormState> _formKey, BuildContext context) {
  String? t_username, t_password, t_email;
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
          padding: const EdgeInsets.all(10.0),
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
                    if (value!.isEmpty) {
                      return 'Forneça a conta';
                    }
                    t_username = value;
                    return null;
                  },
                  initialValue: '',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'E-Mail',
                  ),
                  validator: (value) {
                    t_email = value!;
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(t_email!)) {
                      return 'Forneça um email válido';
                    }
                    t_email = value;
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
                    if (value!.isEmpty) {
                      return 'Forneça a senha';
                    }
                    t_password = value;
                    return null;
                  },
                  initialValue: '',
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Repita a Senha',
                    icon: Icon(Icons.security_rounded),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entre com a senha novamente aqui';
                    }
                    if (t_password != value) {
                      return 'Senhas não conferem';
                    }
                    return null;
                  },
                  initialValue: '',
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //TODO criar o processo de signup no bloc
                            SignUpBloc signUploc = context.read<SignUpBloc>();
                            signUploc.add(SignUp(
                                username: t_username!,
                                password: t_password!,
                                email: t_email!));
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
