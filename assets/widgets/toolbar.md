**toolbar.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/todo.dart';
import '../services/todoService.dart';

class Toolbar extends HookWidget {
  const Toolbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColorFor(SearchCategory category, SearchCategory value) {
      return category == value ? Colors.blue : null;
    }

    final sc = useStream(searchCategory$, initialData: SearchCategory.All).data;
    final activeTodosInfo = useStream(activeItem$, initialData: '').data;
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              activeTodosInfo,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
              key: allFilterKey,
              message: 'All todos',
              child: FlatButton(
                onPressed: () => allTodos(),
                visualDensity: VisualDensity.compact,
                textColor: textColorFor(SearchCategory.All, sc),
                child: const Text('All'),
              )),
          Tooltip(
              key: activeFilterKey,
              message: 'Only uncompleted todos',
              child: FlatButton(
                onPressed: () => activeTodos(),
                visualDensity: VisualDensity.compact,
                textColor: textColorFor(SearchCategory.Active, sc),
                child: const Text('Active'),
              )),
          Tooltip(
              key: completedFilterKey,
              message: 'Only completed todos',
              child: FlatButton(
                onPressed: () => completedTodos(),
                visualDensity: VisualDensity.compact,
                textColor: textColorFor(SearchCategory.Completed, sc),
                child: const Text('Completed'),
              )),
        ],
      ),
    );
  }
}

```
