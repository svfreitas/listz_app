part of 'listz_bloc.dart';

@immutable
abstract class ListzEvent {}

class GetLists extends ListzEvent {}

class GetListItems extends ListzEvent {
  final String listName;
  GetListItems(this.listName);
}
