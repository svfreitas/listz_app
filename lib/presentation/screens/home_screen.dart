import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:listz_app/logic/bloc/listz/listz_bloc.dart';

import 'components/account.dart';
import 'components/config.dart';
import 'components/lists.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ListzBloc _listzBloc;
  String? _name;
  String? _description;
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 1;
  String _title = 'ListZ';
  final List<Widget> _children = [
    Account(),
    Lists(),
    Config(),
  ];

  @override
  void initState() {
    _listzBloc = context.read<ListzBloc>();
    _listzBloc.add(GetLists());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Center(child: Text(_title)),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              onPressed: () async {
                await showCreateListDialog(context);
              })
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
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
                "Configurações",
                //        style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Future<void> showCreateListDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple[400],
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.list),
                        hintText: 'Nome da lista',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Forneça o nome da lista';
                        }
                        _name = value;
                        return null;
                      },
                      initialValue: '',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.description),
                        hintText: 'Descrição',
                      ),
                      validator: (value) {
                        _description = value;
                        return null;
                      },
                      initialValue: '',
                    )
                  ],
                )),
            actions: [
              FlatButton(
                color: Theme.of(context).primaryColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {}
                  Navigator.of(context).pop();
                  ListzBloc listzBloc = context.read<ListzBloc>();
                  listzBloc
                      .add(CreateList(name: _name, description: _description));
                },
                child: Center(child: Text('Criar')),
              ),
            ],
          );
        });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'Conta';

          break;
        case 1:
          _title = 'Suas Listas';
          break;
        case 2:
          _title = 'Configurações';
      }
    });
  }
}
