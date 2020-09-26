import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import '../states/todoState.dart';
import '../models/todo.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColorFor(String category, String value) {
      return category == value ? Colors.blue : null;
    }

    final searchCategory$ = select<TodoState>('todo')
        .map((state) => state.searchCategory)
        .distinct();

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<int>(
              stream: select<TodoState>('todo').map((state) =>
                  state.todos.where((todo) => !todo.completed).length),
              initialData: 0,
              builder: (context, snapshot) {
                return Expanded(
                  child: Text(
                    '${snapshot.data} items left',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: StreamBuilder<String>(
                stream: searchCategory$,
                initialData: '',
                builder: (context, snapshot) {
                  return FlatButton(
                    onPressed: () =>
                        dispatch(TodoFilterAction(type: TodoActionTypes.all)),
                    visualDensity: VisualDensity.compact,
                    textColor: textColorFor(TodoActionTypes.all, snapshot.data),
                    child: const Text('All'),
                  );
                }),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: StreamBuilder<Object>(
                stream: searchCategory$,
                initialData: '',
                builder: (context, snapshot) {
                  return FlatButton(
                    onPressed: () => dispatch(
                        TodoFilterAction(type: TodoActionTypes.active)),
                    visualDensity: VisualDensity.compact,
                    textColor:
                        textColorFor(TodoActionTypes.active, snapshot.data),
                    child: const Text('Active'),
                  );
                }),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: StreamBuilder<Object>(
                stream: searchCategory$,
                initialData: '',
                builder: (context, snapshot) {
                  return FlatButton(
                    onPressed: () => dispatch(
                        TodoFilterAction(type: TodoActionTypes.completed)),
                    visualDensity: VisualDensity.compact,
                    textColor:
                        textColorFor(TodoActionTypes.completed, snapshot.data),
                    child: const Text('Completed'),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
