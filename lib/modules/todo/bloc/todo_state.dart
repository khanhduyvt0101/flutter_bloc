part of 'todo_bloc.dart';

abstract class TodoState {
  const TodoState();
}

class TodoInitial extends TodoState {}

class LoadingTodoState extends TodoState {}

class LoadedTodoState extends TodoState {
  final List<Todo> todo;

  LoadedTodoState(this.todo);
}

class ReloadTodoState extends TodoState {
  final List<Todo> todo;

  ReloadTodoState(this.todo);
}

class AddedTodoState extends TodoState {}
