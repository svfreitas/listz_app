import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/items/items_bloc.dart';
import 'package:listz_app/logic/bloc/listz/listz_bloc.dart';
import 'package:listz_app/data/models/listz_model.dart';
import 'package:listz_app/presentation/screens/items_screen.dart';

class Lists extends StatefulWidget {
  @override
  _ListzListState createState() => _ListzListState();
}

class _ListzListState extends State<Lists> {
  late Widget _savedWidget = buildInitialInput();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            _savedWidget = buildListView(context, state.lists);
            return _savedWidget;
          } else if (state is ListzBuilt) {
            return _savedWidget;
          } else {
            return buildInitialInput();
          }
        },
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

  Widget buildListView(BuildContext ctx, List<ListZ> lists) {
    return RefreshIndicator(
        child: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) {
            ListZ list = lists[index];
            return makeCard(ctx, list);
          },
        ),
        onRefresh: _refreshList);
  }

  Future<Null> _refreshList() async {
    var listzBloc = context.read<ListzBloc>();
    listzBloc.add(GetLists());
  }
//------------------------------
}

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
