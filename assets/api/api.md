**api.dart**

```dart
import '../models/todo.dart';
import 'package:rxdart/rxdart.dart';

Stream<List<Todo>> getTodos() => Stream.value([
      Todo(description: 'Hi'),
      Todo(description: 'Hello'),
      Todo(description: 'Learn Reactive programming')
    ]).delay(const Duration(seconds: 1));

Stream<Todo> addTodo(Todo todo) =>
    Stream.value(todo).delay(const Duration(seconds: 1));

Stream<Todo> updateTodo(Todo todo) {
  if (todo.completed && todo.description.startsWith('Learn Reactive'))
    return Stream.error(
        'Please take your time. Learning reactive programming is not so easy.');
  return Stream.value(todo).delay(const Duration(seconds: 1));
}

Stream<Todo> removeTodo(Todo todo) =>
    Stream.value(todo).delay(const Duration(seconds: 1));

```