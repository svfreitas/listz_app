// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/listz_bloc.dart';
import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/data/models/listz_model.dart';
import 'package:listz_app/presentation/screens/items_screen.dart';

class ItemsScreen extends StatefulWidget {
  static String routeName = "/items";
  String _listName;

  ItemsScreen(String list) {
    this._listName = list;
  }

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<ListzBloc, ListzState>(
          listener: (context, state) {
            if (state is ListzError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ListzLoading) {
              return buildLoading();
            } else if (state is ListzListItemsLoaded) {
              return buildItemsListview(context, state.items);
            } else {
              return buildError();
            }
          },
        ),
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
Card makeCard(Item item) {
  return Card(
    color: Colors.blue[50],
    shadowColor: Colors.blue[250],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 8.0,
    margin: new EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Container(
      //decoration: BoxDecoration(color: Colors.blue[50]),
      child: makeListItems(item),
    ),
  );
}

ListTile makeListItems(Item item) {
  return ListTile(
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('${item.value}'),
    ]),
    //trailing: Icon(Icons.keyboard_arrow_right),
    onTap: () {},
    subtitle: Column(children: [Text('${item.expireDate.toLocal()}')]),
  );
}

ListView buildItemsListview(BuildContext ctx, List<Item> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      Item item = items[index];
      return makeCard(item);
    },
  );
}

//------------------------------

Column buildColumnWithData2(List<Item> items) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
        items.toString(),
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        // Display the temperature with 1 decimal place
        "${items.length}",
        style: TextStyle(fontSize: 80),
      ),
    ],
  );
}

class ListListzButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => submitGetLists(context), child: Text("Get Lists"));
  }

  void submitGetLists(BuildContext context) {
    final listzBloc = context.read<ListzBloc>();
    listzBloc.add(GetLists());
  }
}

class ListListzItemsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => submitGetLists(context),
        child: Text("Get List Items"));
  }

  void submitGetLists(BuildContext context) {
    final listzBloc = context.read<ListzBloc>();
    listzBloc.add(GetListItems("list1"));
  }
}

class ItemsScreenArguments {
  final String listName;

  ItemsScreenArguments(this.listName);
}

/*

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/data/models/listz_model.dart';

class ItemsScreen extends StatefulWidget {

  ListZ list;

  ItemsScreen(list) {
    this.list = list;
  }
  @override
  ItemsScreenState createState() {
    return ItemsScreenState(list);
  }
}

class ItemsScreenState extends State<ItemsScreen> {
  List<Item> items;
  ListZ list;

  ItemsScreenState(list) {
    this.list = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.list.name),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: getItemsFromAPI(http.Client(), this.list.name),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListOfItems(listOfItems: snapshot.data, context: context)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



class ListOfItems extends StatelessWidget {
  final List<Item> listOfItems;
  final BuildContext context;

  ListOfItems({Key key, this.listOfItems, this.context}) : super(key: key);

  Card makeCard(Item item) {
    return Card(
      color: Colors.blue[50],
      shadowColor: Colors.blue[250],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      margin: new EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        //decoration: BoxDecoration(color: Colors.blue[50]),
        child: makeListItems(item),
      ),
    );
  }

  ListTile makeListItems(Item item) {
    return ListTile(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${item.value}'),
      ]),
      //trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
      subtitle: Column(children: [Text('${item.expireDate.toLocal()}')]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfItems.length,
      itemBuilder: (context, index) {
        Item item = listOfItems[index];
        return makeCard(item);
      },
    );
  }
}
*/
