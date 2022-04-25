// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_observer.dart';

import 'firstScreen.dart';

void main() {
  BlocOverrides.runZoned((){
    runApp(MyApp());
  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          //#5e228f
          backgroundColor: Color(0xFF5e228f),
          foregroundColor: Colors.white,
        ),
      ),
      home: FirstScreen(),
    );
  }
}


