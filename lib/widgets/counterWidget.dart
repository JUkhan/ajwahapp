import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:hello_world/models/specialEffectModel.dart';
import '../models/asyncData.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: select<SpecialEffectModel>('special-effect')
            .map((model) => model.hasState),
        initialData: false,
        builder: (context, snapshot) {
          return !snapshot.data
              ? Text('Please add counter state by clicking [Add State] button')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => dispatch(Action(type: 'Inc')),
                      child: Text('+'),
                    ),
                    RaisedButton(
                      onPressed: () => dispatch(Action(type: 'Dec')),
                      child: Text('-'),
                    ),
                    StreamBuilder<bool>(
                      stream: select<SpecialEffectModel>('special-effect')
                          .map((model) => model.hasEffect),
                      initialData: false,
                      builder: (context, snapshot) => RaisedButton(
                        onPressed: () => dispatch(Action(type: 'AsyncInc')),
                        child: Text(
                          'Async +',
                          style: TextStyle(
                              color: snapshot.data ? Colors.red : null),
                        ),
                      ),
                    ),
                    StreamBuilder<AsyncData<int>>(
                      stream: select('counter'),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data.asyncStatus ==
                                  AsyncStatus.Loading
                              ? CircularProgressIndicator()
                              : Text(
                                  '  ${snapshot.data.data}',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.blue),
                                );
                        }
                        return Container();
                      },
                    ),
                  ],
                );
        });
  }
}
