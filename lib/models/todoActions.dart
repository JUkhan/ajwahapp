import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:meta/meta.dart';
import 'todo.dart';

abstract class TodoActions {
  static const loadtodos = 'todos-loadtodo';
  static const loadEnd = 'todos-loaded';
  static const addTodo = 'todos-add';
  static const addEnd = 'todos-added';
  static const updateTodo = 'todos-update';
  static const updateEnd = 'todos-update-end';
  static const removeTodo = 'todos-remove';
  static const removeEnd = 'todos-remove-end';
  static const searchCategory = 'todos-search-category';
  static const error = 'todos-error';
  static const errorEnd = 'todos-error-end';
}

class TodoAction extends Action {
  final List<Todo> todos;
  final Todo todo;
  final SearchCategory searchCategory;
  TodoAction({
    @required String type,
    this.todos,
    this.todo,
    this.searchCategory,
  }) : super(type: type);
}

class ErrorAction extends Action {
  final dynamic error;
  ErrorAction({
    @required String type,
    this.error,
  }) : super(type: type);
}
