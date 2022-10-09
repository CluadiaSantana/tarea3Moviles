import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea3/pages/bloc/book_bloc.dart';
import 'pages/home_page.dart';

void main() => runApp(BlocProvider(
      create: (context) => BookBloc(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Colors.black,
        //other options
      )),
      home: HomePage(),
    );
  }
}
