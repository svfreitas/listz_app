import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/listz_bloc.dart';
import 'package:listz_app/presentation/routes/app_router.dart';
import 'package:listz_app/presentation/screens/home_screen.dart';

import 'data/repositories/listz_repository.dart';
import 'logic/bloc/items_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final _repository = ListzRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ListzBloc>(
            create: (context) => ListzBloc(_repository),
          ),
          BlocProvider<ItemsBloc>(
            create: (context) => ItemsBloc(_repository),
          )
        ],
        child: MaterialApp(
          title: 'Material App',
          onGenerateRoute: _appRouter.onGenerateRoute,
        ));
  }
}
