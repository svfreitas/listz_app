import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/listz/listz_bloc.dart';
import 'package:listz_app/presentation/routes/app_router.dart';

import 'data/repositories/listz_repository.dart';
import 'logic/bloc/items/items_bloc.dart';
import 'logic/bloc/login/login_bloc.dart';

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
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(_repository),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
              primaryColor: Colors.deepPurple,
              accentColor: Colors.yellow[400],
              textTheme: ThemeData.dark().textTheme.copyWith(
                    bodyText2: TextStyle(
                      color: Colors.black,
                    ),
                  )),
          title: 'Listz App',
          onGenerateRoute: _appRouter.onGenerateRoute,
        ));
  }
}
