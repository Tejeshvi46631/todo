import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';
import 'package:todo/model/todo_model.dart';

class EditTodoDialog extends StatelessWidget {
  final Todo todo;

  const EditTodoDialog({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: todo.title);

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        // Use BlocProvider.value to access TodoBloc from context
        return BlocProvider.value(
          value: BlocProvider.of<TodoBloc>(context),
          child: AlertDialog(
            title: Text('Edit Todo'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter new title',
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  // Dispatch EditTodo event to TodoBloc
                  BlocProvider.of<TodoBloc>(context).add(
                    EditTodo(
                      id: todo.id,
                      title: controller.text,
                    ),
                  );

                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Close DetailsScreen
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
