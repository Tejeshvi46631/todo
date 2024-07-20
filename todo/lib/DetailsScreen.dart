import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_state.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/EditTodoDialog.dart'; // Adjust path as per your project structure

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context)!.settings.arguments as Todo;

    return BlocProvider(
      create: (context) => TodoBloc(), // Provide your TodoBloc instance here
      child: Scaffold(
        appBar: AppBar(
          title: Text('To-Do Details'),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                  
                    return BlocProvider.value(
                      value: BlocProvider.of<TodoBloc>(context),
                      child: EditTodoDialog(todo: todo),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              // Access TodoBloc state here
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Status:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    todo.completed ? 'Completed' : 'Not Completed',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: todo.completed ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
