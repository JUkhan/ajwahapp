import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../services/todoService.dart';
import '../models/todo.dart';

class TodoItem extends HookWidget {
  final Todo todo;
  const TodoItem({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldFocusNode = useFocusNode();
    final itemFocusNode = useFocusNode();
    final textEditingController = useTextEditingController();
    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else if (textEditingController.text != todo.description) {
            updateTodo(todo.copyWith(description: textEditingController.text));
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
              value: todo.completed,
              onChanged: (value) =>
                  updateTodo(todo.copyWith(completed: value))),
          title: itemFocusNode.hasFocus
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}
