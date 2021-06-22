import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/modules/todo/api/todo_api_provider.dart';
import 'package:bloc_example/modules/todo/model/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial());
  List<Todo> todo = [];
  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    switch (event.runtimeType) {

      /// ADD TO DO
      case AddTodoEvent:
        todo = [];
        await TodoApiProvider.addTodo(
            event.props[1], event.props[2], event.props[0]);
        yield AddedTodoState();
        break;

      ///LOAD TO DO
      case LoadTodoEvent:
        print('load event');
        yield LoadingTodoState();
        if (todo.isEmpty) todo = await TodoApiProvider.loadTodo(event.props[0]);
        yield LoadedTodoState(todo);
        break;

      ///DELETE TO DO
      case CheckTodoEvent:
        TodoApiProvider.checkTodo(event.props[0].toString(), event.props[1]);
        for (int i = 0; i < todo.length; i++) {
          if (todo[i].id == event.props[0]) {
            todo.removeAt(i);
            break;
          }
        }
        yield ReloadTodoState(todo);

        yield LoadedTodoState(todo);
        break;

      ///REMOVE LIST
      case RemoveTodoEvent:
        todo = [];
        break;
      default:
    }
  }
}
