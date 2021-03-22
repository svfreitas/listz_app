part of 'listz_bloc.dart';

@immutable
abstract class ListzEvent {}

class GetLists extends ListzEvent {}

class SetListzBuilt extends ListzEvent {}
