part of 'listz_bloc.dart';

@immutable
abstract class ListzEvent {}

class GetLists extends ListzEvent {}

class CreateList extends ListzEvent {
  final String? name;
  final String? description;

  CreateList({required this.name, required this.description});

  @override
  List<Object?> get props => [name, description];
}
