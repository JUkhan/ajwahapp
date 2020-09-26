**counterState.dart**

```dart
import 'package:ajwah_bloc/ajwah_bloc.dart';
import '../models/asyncData.dart';

void registerCounterState() {
  registerState<AsyncData<int>>(
      stateName: 'counter',
      initialState: AsyncData.loaded(10),
      mapActionToState: (state, action, emit) async {
        switch (action.type) {
          case 'Inc':
            emit(AsyncData.loaded(state.data + 1));
            break;
          case 'Dec':
            emit(AsyncData.loaded(state.data - 1));
            break;
          case 'AsyncInc':
            emit(AsyncData.loading(state.data));
            await Future.delayed(Duration(seconds: 1));
            dispatch(Action(type: 'Inc'));
            break;
          default:
        }
      });
}

```
