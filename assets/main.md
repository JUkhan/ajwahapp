**main.dart**

```dart
import 'states/themeState.dart';
import 'pages/homePage.dart';
import 'pages/codeViewerPage.dart';
import 'package:flutter/material.dart';
import 'package:ajwah_bloc/ajwah_bloc.dart';

void main() {
  createStore(exposeApiGlobally: true);
  registerThemeState();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Brightness>(
        stream: select('theme'),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(brightness: snapshot.data),
            initialRoute: '/',
            routes: {
              '/': (_) => HomePage(),
              '/code': (_) => CodeViewerPage(),
            },
          );
        });
  }
}


```