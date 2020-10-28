**todoState.dart**

```dart
import '../api/todoApi.dart';
import '../models/todoActions.dart';
import '../models/todo.dart';
import '../states/store.dart';

void registerTodoState() {
  store.registerState<TodoState>(
      stateName: 'todos',
      initialState: TodoState(todos: [], searchCategory: SearchCategory.All),
      mapActionToState: (state, action, emit) {
        if (action is TodoAction) {
          switch (action.type) {
            case TodoActions.loadEnd:
              emit(state.copyWith(todos: action.todos));
              break;
            case TodoActions.loadtodos:
              callApi<List<Todo>>(
                getTodos(),
                (apiRes) =>
                    TodoAction(type: TodoActions.loadEnd, todos: apiRes),
              );
              break;
            case TodoActions.addEnd:
              emit(state.copyWith(todos: [action.todo, ...state.todos]));
              break;
            case TodoActions.addTodo:
              callApi<Todo>(
                addTodo(action.todo),
                (apiRes) => TodoAction(type: TodoActions.addEnd, todo: apiRes),
              );
              break;
            case TodoActions.updateEnd:
              emit(state.copyWith(todos: [
                for (var item in state.todos)
                  if (item.id == action.todo.id) action.todo else item,
              ]));
              break;
            case TodoActions.updateTodo:
              callApi<Todo>(
                updateTodo(action.todo),
                (apiRes) =>
                    TodoAction(type: TodoActions.updateEnd, todo: apiRes),
              );
              break;
            case TodoActions.removeEnd:
              emit(state.copyWith(
                  todos: state.todos
                      .where((item) => item.id != action.todo.id)
                      .toList()));
              break;
            case TodoActions.removeTodo:
              callApi<Todo>(
                removeTodo(action.todo),
                (apiRes) =>
                    TodoAction(type: TodoActions.removeEnd, todo: apiRes),
              );
              break;
            case TodoActions.searchCategory:
              emit(state.copyWith(searchCategory: action.searchCategory));
              break;
          }
        }
      });
}

typedef EmitAction<S> = TodoAction Function(S apiRes);

void callApi<S>(Stream<S> api$, EmitAction<S> mapCallback) {
  api$.map(mapCallback).listen((action) => store.dispatch(action),
      onError: (err) =>
          store.dispatch(ErrorAction(type: TodoActions.error, error: err)),
      onDone: () => print('Done'));
}

```
