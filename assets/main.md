**main.dart**

```dart
import './pages/todoPage.dart';
import 'pages/codeViewerPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (_) => TodoPage(),
        '/code': (_) => CodeViewerPage(),
      },
    );
  }
}

```