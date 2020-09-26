import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:meta/meta.dart';
import '../models/todo.dart';

class TodoAction extends Action {
  String description;
  String id;
  TodoAction({
    @required String type,
    this.id,
    this.description,
  }) : super(type: type);
}

class TodoFilterAction extends Action {
  TodoFilterAction({@required String type}) : super(type: type);
}

abstract class TodoActionTypes {
  static const all = 'todo-all';
  static const active = 'todo-active';
  static const completed = 'todo-completed';
  static const add = 'todo-add';
  static const update = 'todo-update';
  static const toggle = 'todo-toggle';
  static const remove = 'todo-remove';
}

void registerTodoState() {
  registerState<TodoState>(
    stateName: 'todo',
    filterActions: (action) =>
        action is TodoAction || action is TodoFilterAction,
    initialState: TodoState(
      todos: [
        Todo(id: 'todo-0', description: 'hi'),
        Todo(id: 'todo-1', description: 'hello'),
        Todo(id: 'todo-2', description: 'bonjour'),
      ],
      searchCategory: TodoActionTypes.all,
    ),
    mapActionToState: (state, action, emit) {
      if (action is TodoAction)
        switch (action.type) {
          case TodoActionTypes.add:
            emit(state.copyWith(todos: [
              ...state.todos,
              Todo(description: action.description)
            ]));
            break;
          case TodoActionTypes.update:
            emit(state.copyWith(todos: [
              for (var item in state.todos)
                if (item.id == action.id)
                  Todo(
                      id: item.id,
                      completed: item.completed,
                      description: action.description)
                else
                  item,
            ]));
            break;
          case TodoActionTypes.toggle:
            emit(state.copyWith(todos: [
              for (var item in state.todos)
                if (item.id == action.id)
                  Todo(
                      id: item.id,
                      completed: !item.completed,
                      description: item.description)
                else
                  item,
            ]));
            break;
          case TodoActionTypes.remove:
            emit(state.copyWith(
                todos: state.todos
                    .where((item) => item.id != action.id)
                    .toList()));
            break;
        }
      else if (action is TodoFilterAction) {
        emit(state.copyWith(searchCategory: action.type));
      }
    },
  );
}

Stream<List<Todo>> getFilteredTodos() => select<TodoState>('todo').map((state) {
      switch (state.searchCategory) {
        case TodoActionTypes.active:
          return state.todos.where((todo) => !todo.completed).toList();
        case TodoActionTypes.completed:
          return state.todos.where((todo) => todo.completed).toList();
        default:
          return state.todos;
      }
    });
