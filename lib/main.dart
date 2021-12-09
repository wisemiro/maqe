import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqe/nav-bar/home/bloc_observer.dart';
import 'package:maqe/nav-bar/home/blocs/bloc/read_json_bloc.dart';
import 'package:maqe/nav-bar/home/service_locator.dart';
import 'package:maqe/nav-bar/nav-bar.dart';
import 'package:maqe/theme/colors.dart';

void main() {
  setup();
  BlocOverrides.runZoned(() {},
    blocObserver: SimpleBlocObserver(),
  );

  runApp(BlocProvider(
    create: (context) => ReadJsonBloc()..add(ReadJson()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maqe Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: MaqeColor.iconColor),
        backgroundColor: MaqeColor.background
      ),
      home: NavBar(),
    );
  }
}
