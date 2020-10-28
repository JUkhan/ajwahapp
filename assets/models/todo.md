**todo.dart**

```dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Todo {
  Todo({
    this.description,
    this.completed = false,
    String id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String description;
  final bool completed;

  Todo copyWith({
    String id,
    String description,
    bool completed,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

enum SearchCategory { All, Active, Completed }

class TodoState {
  final SearchCategory searchCategory;
  final List<Todo> todos;
  TodoState({
    this.searchCategory,
    this.todos,
  });

  TodoState copyWith({
    SearchCategory searchCategory,
    List<Todo> todos,
  }) {
    return TodoState(
      searchCategory: searchCategory ?? this.searchCategory,
      todos: todos ?? this.todos,
    );
  }
}

```
