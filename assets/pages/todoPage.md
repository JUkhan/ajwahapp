**todoPage.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_world/states/todoState.dart';
import '../widgets/error.dart';
import '../widgets/loading.dart';
import '../services/todoService.dart';
import '../widgets/drawerWidget.dart';
import '../widgets/todoItem.dart';
import '../models/todo.dart';
import '../widgets/toolbar.dart';
import '../widgets/title.dart';

class TodoPage extends HookWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTodoController = useTextEditingController();
    final todos = useStream(todos$, initialData: []).data;
    useEffect(() {
      registerTodoState();
      loadTodos();
      return null;
    }, []);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
        ),
        drawer: DrawerWidget(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const Loading(),
            const Errors(),
            const TitleWidget(),
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: 'What needs to be done?',
              ),
              onSubmitted: (value) {
                addTodo(Todo(description: value));
                newTodoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            ...[
              for (var i = 0; i < todos.length; i++) ...[
                if (i > 0) const Divider(height: 0),
                Dismissible(
                  key: ValueKey(todos[i].id),
                  onDismissed: (_) {
                    removeTodo(todos[i]);
                  },
                  child: TodoItem(
                    //key: Key(todos[i].id),
                    todo: todos[i],
                  ),
                )
              ]
            ],
          ],
        ),
      ),
    );
  }
}
```
