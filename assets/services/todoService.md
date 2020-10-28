**todoService.dart**

```dart
import '../models/todoActions.dart';
import '../models/todo.dart';
import '../states/store.dart';
import 'package:rxdart/rxdart.dart';

final _todoState$ = store.select<TodoState>('todos');

Stream<List<Todo>> todos$ = _todoState$.map((state) {
  switch (state.searchCategory) {
    case SearchCategory.Active:
      return state.todos.where((todo) => !todo.completed).toList();
    case SearchCategory.Completed:
      return state.todos.where((todo) => todo.completed).toList();
    default:
      return state.todos;
  }
});
final searchCategory$ = _todoState$.map((state) => state.searchCategory);

final activeItem$ = _todoState$
    .map((state) => state.todos.where((todo) => !todo.completed).toList())
    .map((todos) => '${todos.length} items left');

final _start$ = store.actions.whereTypes([
  TodoActions.loadtodos,
  TodoActions.addTodo,
  TodoActions.updateTodo,
  TodoActions.removeTodo
]).map((event) => true);

final _end$ = store.actions.whereTypes([
  TodoActions.loadEnd,
  TodoActions.addEnd,
  TodoActions.updateEnd,
  TodoActions.removeEnd
]).map((event) => false);

final _error$ = store.actions.whereType(TodoActions.error);

final _errorEnd$ = _error$.delay(const Duration(seconds: 5));

final error$ = Rx.merge([
  _error$.map((action) => action is ErrorAction ? action.error.toString() : ''),
  _errorEnd$.map((event) => '')
]).asBroadcastStream();

final loading$ = Rx.merge([_start$, _end$, _errorEnd$.map((event) => false)])
    .startWith(false)
    .asBroadcastStream();

final added$ = store.actions.whereType(TodoActions.addEnd);

final updated$ = store.actions.whereType(TodoActions.updateEnd);

loadTodos() {
  if (store.getState<TodoState>(stateName: 'todos').todos.length == 0) {
    store.dispatch(TodoAction(type: TodoActions.loadtodos));
  }
}

allTodos() {
  store.dispatch(TodoAction(
      type: TodoActions.searchCategory, searchCategory: SearchCategory.All));
}

activeTodos() {
  store.dispatch(TodoAction(
      type: TodoActions.searchCategory, searchCategory: SearchCategory.Active));
}

completedTodos() {
  store.dispatch(TodoAction(
      type: TodoActions.searchCategory,
      searchCategory: SearchCategory.Completed));
}

removeTodo(Todo todo) {
  store.dispatch(TodoAction(type: TodoActions.removeTodo, todo: todo));
}

updateTodo(todo) {
  store.dispatch(TodoAction(type: TodoActions.updateTodo, todo: todo));
}

addTodo(todo) {
  store.dispatch(TodoAction(type: TodoActions.addTodo, todo: todo));
}

```