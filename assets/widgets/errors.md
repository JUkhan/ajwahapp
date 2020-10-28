**Errors.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_world/services/todoService.dart';

class Errors extends HookWidget {
  const Errors({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final error = useStream(error$, initialData: '').data;
    return Container(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

```
