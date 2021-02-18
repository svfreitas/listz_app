import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/items_bloc.dart';
import 'package:listz_app/logic/bloc/listz_bloc.dart';
import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/data/models/listz_model.dart';
import 'package:listz_app/presentation/screens/items_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListzBloc _listzBloc;

  @override
  void initState() {
    _listzBloc = context.read<ListzBloc>();
    _listzBloc.add(GetLists());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListZ"),
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
            if (state is ListzInitial) {
              return buildInitialInput();
            } else if (state is ListzLoading) {
              return buildLoading();
            } else if (state is ListzListsLoaded) {
              return buildListView(context, state.lists);
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
        // child: ListListzButton(),
        );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

//------------------------------
Card makeCard(BuildContext ctx, ListZ list) {
  return Card(
    color: Colors.blue[50],
    shadowColor: Colors.blue[250],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 8.0,
    margin: new EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Container(
      child: makeListTile(ctx, list),
    ),
  );
}

ListTile makeListTile(BuildContext ctx, ListZ list) {
  return ListTile(
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('${list.name}'),
      Text('${list.itemCount}'),
    ]),
    trailing: Icon(Icons.keyboard_arrow_right),
    onTap: () {
      final ItemsBloc itemsBloc = ctx.read<ItemsBloc>();
      itemsBloc.add(GetListItems(list.name));
      Navigator.pushNamed(ctx, ItemsScreen.routeName,
          arguments: ItemsScreenArguments(list.name));
    },
    subtitle: Column(children: [
      Text(' ${list.description}'),
      Text('${list.creationDate.toLocal()}')
    ]),
  );
}

ListView buildListView(BuildContext ctx, List<ListZ> lists) {
  return ListView.builder(
    itemCount: lists.length,
    itemBuilder: (context, index) {
      ListZ list = lists[index];
      return makeCard(ctx, list);
    },
  );
}

//------------------------------

class ListListzButton extends StatelessWidget {
  @override
  ListListzButton() {}
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
