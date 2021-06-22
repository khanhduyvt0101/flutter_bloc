part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoEvent extends TodoEvent {
  final String userId;

  LoadTodoEvent(this.userId);
  @override
  List<Object> get props => [this.userId];
}

class CheckTodoEvent extends TodoEvent {
  final String id;
  final String userId;

  CheckTodoEvent(this.id, this.userId);
  @override
  List<Object> get props => [this.id, this.userId];
}

class AddTodoEvent extends TodoEvent {
  final String title, note, userId;

  AddTodoEvent(
    this.userId,
    this.title,
    this.note,
  );
  @override
  List<Object> get props => [
        this.userId,
        this.title,
        this.note,
      ];
}

class UpdateTodoEvent extends TodoEvent {}

class DeleteTodoEvent extends TodoEvent {}

class RemoveTodoEvent extends TodoEvent {}
