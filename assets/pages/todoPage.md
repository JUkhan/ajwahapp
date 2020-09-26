**todoPage.dart**

```dart
import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import '../states/todoState.dart';
import '../widgets/drawerWidget.dart';
import '../widgets/todoItem.dart';
import '../models/todo.dart';
import '../widgets/toolbar.dart';
import '../widgets/title.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController newTodoController;

  @override
  void initState() {
    newTodoController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    newTodoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('todo list'),
        ),
        drawer: DrawerWidget(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const TitleWidget(),
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: 'What needs to be done?',
              ),
              onSubmitted: (value) {
                dispatch(
                    TodoAction(type: TodoActionTypes.add, description: value));
                newTodoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            StreamBuilder<List<Todo>>(
              stream: getFilteredTodos(),
              initialData: [],
              builder: (context, snapshot) {
                final todos = snapshot.data;
                return Column(
                  children: [
                    for (var i = 0; i < todos.length; i++) ...[
                      if (i > 0) const Divider(height: 0),
                      Dismissible(
                        key: ValueKey(todos[i].id),
                        onDismissed: (_) {
                          dispatch(TodoAction(
                              type: TodoActionTypes.remove, id: todos[i].id));
                        },
                        child: TodoItem(
                          //key: Key(todos[i].id),
                          todo: todos[i],
                        ),
                      )
                    ]
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

```
