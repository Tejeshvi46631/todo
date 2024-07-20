import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/DetailsScreen.dart';
import 'package:todo/TodoListScreen.dart';
import 'package:todo/bloc/todo_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: MaterialApp(
        title: 'To-Do List',
        home: TodoListScreen(),
        routes: {
          '/details': (context) => DetailsScreen(),
        },
      ),
    );
  }
}
