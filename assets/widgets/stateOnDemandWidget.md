**stateonDemandWidget.dart**

```dart
import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/specialEffectModel.dart';
import '../models/asyncData.dart';
import '../states/counterState.dart';

class StateOnDemandWidget extends StatelessWidget {
  const StateOnDemandWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          onPressed: registerCounterState,
          child: Text('Add State'),
        ),
        RaisedButton(
          onPressed: () =>
              storeInstance().unregisterState(stateName: 'counter'),
          child: Text('Remove State'),
        ),
        RaisedButton(
          onPressed: () {
            registerCounterState();
            storeInstance()
              ..unregisterEffect(effectKey: 'effectKey')
              ..importState({
                'counter': AsyncData.loaded(10),
                'theme': Brightness.dark,
                'special-effect':
                    SpecialEffectModel(hasEffect: false, hasState: true)
              });
          },
          child: Text('Import State'),
        ),
      ],
    );
  }
}

```
