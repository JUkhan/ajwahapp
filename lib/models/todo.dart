import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

/// A read-only description of a todo-item
class Todo {
  Todo({
    this.description,
    this.completed = false,
    String id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

class TodoState {
  final String searchCategory;
  final List<Todo> todos;
  TodoState({
    this.searchCategory,
    this.todos,
  });

  TodoState copyWith({
    String searchCategory,
    List<Todo> todos,
  }) {
    return TodoState(
      searchCategory: searchCategory ?? this.searchCategory,
      todos: todos ?? this.todos,
    );
  }
}

/// Some keys used for testing
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();
