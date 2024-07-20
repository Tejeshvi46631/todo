import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/model/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<FetchTodos>(_onFetchTodos);
    on<EditTodo>(_onEditTodo);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final todos = Todo.fromJsonList(jsonList);
        emit(TodoLoaded(todos));
      } else {
        emit(TodoError('Failed to fetch todos'));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void _onEditTodo(EditTodo event, Emitter<TodoState> emit) async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${event.id}'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'id': event.id,
          'title': event.title,
          'body': "bar",
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        final updatedTodo = Todo.fromJson(json.decode(response.body));
        add(FetchTodos()); // Refresh the list after editing
      } else {
        emit(TodoError('Failed to edit todo'));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'title': event.title,
          'body': 'bar',
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        add(FetchTodos()); // Refresh the list after adding a new todo
      } else {
        emit(TodoError('Failed to add todo'));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${event.id}'),
      );

      if (response.statusCode == 200) {
        add(FetchTodos()); // Refresh the list after deleting a todo
      } else {
        emit(TodoError('Failed to delete todo'));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
