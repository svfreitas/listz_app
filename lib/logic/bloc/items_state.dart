part of 'items_bloc.dart';

@immutable
abstract class ItemsState {
  const ItemsState();
}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Item> items;
  const ItemsLoaded(
    this.items,
  );

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemsLoaded && listEquals(o.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

class ItemsError extends ItemsState {
  final String message;
  const ItemsError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemsError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
