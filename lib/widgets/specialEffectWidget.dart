import 'package:flutter/material.dart' hide Action;
import 'package:ajwah_bloc/ajwah_bloc.dart';
import '../states/themeState.dart';
import '../widgets/dynamicWidget.dart';
import '../states/specialEffectState.dart';

class SpecialEffectWidget extends StatelessWidget {
  SpecialEffectWidget({Key key}) : super(key: key) {
    registerSpecialEffectState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              onPressed: () => dispatch(Action(type: 'show-widget')),
              child: Text('Show Widget'),
            ),
            RaisedButton(
              onPressed: () => dispatch(Action(type: 'hide-widget')),
              child: Text('Hide Widget'),
            ),
          ],
        ),
        StreamBuilder<String>(
          stream: storeInstance().actions.whereTypes(
              ['show-widget', 'hide-widget']).map((action) => action.type),
          initialData: 'hide-widget',
          builder: (context, snapshot) {
            return snapshot.data == 'show-widget'
                ? DynamicWidget()
                : Container();
          },
        ),
        RaisedButton(
          onPressed: () => dispatch(ThemeToggleAction()),
          child: Text('Toggle Theme'),
        ),
      ],
    );
  }
}
