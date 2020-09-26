**themeState.dart**

```dart

import 'package:ajwah_bloc/ajwah_bloc.dart' as store;
import 'package:flutter/material.dart';
class ThemeToggleAction extends store.Action {}

void registerThemeState() {
  store.registerState<Brightness>(
    stateName: 'theme',
    filterActions: (action) => action is ThemeToggleAction,
    initialState: Brightness.light,
    mapActionToState: (state, action, emit) {
      emit(state == Brightness.light ? Brightness.dark : Brightness.light);
    },
  );
}
```
