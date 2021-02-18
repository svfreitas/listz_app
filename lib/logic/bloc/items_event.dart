part of 'items_bloc.dart';

@immutable
abstract class ItemsEvent {}

class GetListItems extends ItemsEvent {
  final String listName;
  GetListItems(this.listName);
}
