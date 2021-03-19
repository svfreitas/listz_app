// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/logic/bloc/items/items_bloc.dart';

class ItemsScreen extends StatefulWidget {
  static String routeName = "/items";
  String? _listName;

  ItemsScreen(String? list) {
    this._listName = list;
  }

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<ItemsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Itens da lista"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/presentation/images/wallpaper-galaxy.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<ItemsBloc, ItemsState>(
          listener: (context, state) {
            if (state is ItemsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ItemsLoading) {
              return buildLoading();
            } else if (state is ItemsLoaded) {
              return buildItemsListview(context, state.items);
            } else {
              return buildError();
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: 1,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text("Conta"), icon: Icon(Icons.account_box)),
          BottomNavigationBarItem(
              title: Text(
                "Listas",
              ),
              icon: Icon(Icons.apps)),
          BottomNavigationBarItem(
              title: Text(
                "Configuração",
              ),
              icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError() {
    return Center(
      child: Text(":-("),
    );
  }
}

//------------------------------
Widget makeCard(Item item, BuildContext context) {
  return Card(
    color: Colors.transparent,
    //   color: Colors.white,
    //   border: Border.all(
    //    color: Theme.of(context).accentColor,
    //   width: 0.5,
    //    ),
    child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: makeListItem(item),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => {},
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {showAlertDialog2(context)},
        ),
      ],
    ),
  );
}

ListTile makeListItem(Item item) {
  return ListTile(
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        '${item.value}',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    ]),
    //trailing: Icon(Icons.keyboard_arrow_right),
    onTap: () {},
    subtitle: Column(children: [Text('${item.expireDate!.toLocal()}')]),
  );
}

ListView buildItemsListview(BuildContext ctx, List<Item> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      Item item = items[index];
      return makeCard(item, context);
    },
  );
}

//------------------------------

class ItemsScreenArguments {
  final String? listName;

  ItemsScreenArguments(this.listName);
}

showAlertDialog2(BuildContext context) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget continuaButton = FlatButton(
    child: Text("Continar"),
    onPressed: () {
      Navigator.of(context).pop();
      //DeleteItem
    },
  );

  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alerta"),
    content: Text("Deseja realmente apagar o item?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );

  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
