part of 'listz_bloc.dart';

@immutable
abstract class ListzState {
  const ListzState();
}

class ListzInitial extends ListzState {}

class ListzLoading extends ListzState {}

class ListzListsLoaded extends ListzState {
  final List<ListZ> lists;
  const ListzListsLoaded(this.lists);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListzListsLoaded && listEquals(o.lists, lists);
  }

  @override
  int get hashCode => lists.hashCode;
}

class ListzListItemsLoaded extends ListzState {
  final List<Item> items;
  const ListzListItemsLoaded(this.items);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListzListItemsLoaded && listEquals(o.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

class ListzError extends ListzState {
  final String message;
  const ListzError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListzError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

/*
class ListzShowCreateList extends ListzState {
  final ListZ list;
  ListzShowCreateList(this.list);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListzShowCreateList && o.list == list;
  }

  @override
  int get hashCode => list.hashCode;
}

class ListzShowCreateListItem extends ListzState {
  final Item item;
  ListzShowCreateListItem(this.item);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListzShowCreateListItem && o.item == item;
  }

  @override
  int get hashCode => item.hashCode;
}
*/
