import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTodos extends TodoEvent {}

class EditTodo extends TodoEvent {
  final int id;
  final String title;
  

  EditTodo({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
class AddTodo extends TodoEvent {
  final String title;

  AddTodo({required this.title});
}
class DeleteTodo extends TodoEvent {
  final int id;

   DeleteTodo({required this.id});

  @override
  List<Object> get props => [id];
}