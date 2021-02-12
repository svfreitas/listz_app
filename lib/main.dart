import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listz_app/logic/bloc/listz_bloc.dart';
import 'package:listz_app/presentation/routes/app_router.dart';
import 'package:listz_app/presentation/screens/home_screen.dart';

import 'data/repositories/listz_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListzBloc(ListzRepository()),
      child: MaterialApp(
        title: 'Material App',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
