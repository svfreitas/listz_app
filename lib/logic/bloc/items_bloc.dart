import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:listz_app/core/exceptions.dart';
import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/data/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final Repository _repository;
  ItemsBloc(this._repository) : super(ItemsLoading());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if (event is GetListItems) {
      try {
        yield ItemsLoading();
        final items = await _repository.getListItems(event.listName);
        yield ItemsLoaded(items);
      } on ServerException {
        yield ItemsError("Couldn't fetch items. Is the device online?");
      }
    }
  }
}
