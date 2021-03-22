import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/items/items_bloc.dart';
import '../../logic/bloc/listz/listz_bloc.dart';
import '../../data/models/listz_model.dart';
import 'items_screen.dart';

class ListzScreen extends StatefulWidget {
  static String routeName = "/listz";
  @override
  _ListzScreenState createState() => _ListzScreenState();
}

class _ListzScreenState extends State<ListzScreen> {
  late ListzBloc _listzBloc;

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/presentation/images/wallpaper-galaxy.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: BlocConsumer<ListzBloc, ListzState>(
          listener: (context, state) {
            if (state is ListzError) {
              ScaffoldMessenger.of(context).showSnackBar(
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: 1,
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

  Widget buildInitialInput() {
    return Center();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

//------------------------------
Widget makeCard(BuildContext ctx, ListZ list) {
  return Card(
    color: Colors.transparent,
    child: makeListTile(ctx, list),
  );
}

ListTile makeListTile(BuildContext ctx, ListZ list) {
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${list.name}',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: new BoxDecoration(
            color: Theme.of(ctx).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${list.itemCount}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    ),
    onTap: () {
      final ItemsBloc itemsBloc = ctx.read<ItemsBloc>();
      itemsBloc.add(GetListItems(list.name));
      Navigator.pushNamed(ctx, ItemsScreen.routeName,
          arguments: ItemsScreenArguments(list.name));
    },
    subtitle: Column(children: [
      Text(' ${list.description}'),
      // Text('${list.creationDate.toLocal()}')
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
