**todoItem.dart**

```dart

import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import '../states/todoState.dart';
import '../models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  TodoItem({Key key, @required this.todo}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  FocusNode textFieldFocusNode;
  FocusNode itemFocusNode;
  TextEditingController textEditingController;

  @override
  void initState() {
    textFieldFocusNode = FocusNode();
    itemFocusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    itemFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = widget.todo.description;
          } else {
            dispatch(TodoAction(
                type: TodoActionTypes.update,
                id: widget.todo.id,
                description: textEditingController.text));
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
              value: widget.todo.completed,
              onChanged: (value) => dispatch(TodoAction(
                  type: TodoActionTypes.toggle, id: widget.todo.id))),
          title: itemFocusNode.hasFocus
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(widget.todo.description),
        ),
      ),
    );
  }
}


```
