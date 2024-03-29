import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:listz_app/core/exceptions.dart';
import 'package:listz_app/data/models/listz_model.dart';
import 'package:listz_app/data/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'listz_event.dart';
part 'listz_state.dart';

class ListzBloc extends Bloc<ListzEvent, ListzState> {
  final Repository _repository;

  ListzBloc(this._repository) : super(ListzInitial());

  @override
  Stream<ListzState> mapEventToState(
    ListzEvent event,
  ) async* {
    if (event is GetLists) {
      try {
        yield ListzLoading();
        final lists = await _repository.getLists();
        yield ListzListsLoaded(lists);
      } on ServerException {
        yield ListzError("Couldn't fetch lists. Is the device online?");
      }
    } else if (event is CreateList) {
      try {
        await _repository.createList(event.name, event.description);
        yield ListzLoading();
        final lists = await _repository.getLists();
        yield ListzListsLoaded(lists);
      } on ServerException {
        yield ListzError("Não foi possivel criar a lista");
      }
    }
  }
}
