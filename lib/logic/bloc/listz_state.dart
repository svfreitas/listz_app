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
