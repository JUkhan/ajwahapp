import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart' hide Action;
import '../models/specialEffectModel.dart';
import 'package:rxdart/rxdart.dart';

class DynamicWidget extends StatelessWidget {
  final _effectKey = "effectKey";

  void _addEffectForAsyncInc() {
    storeInstance().registerEffect(
      (action$, store$) => action$
          .whereType('AsyncInc')
          .debounceTime(Duration(milliseconds: 500))
          .map((event) => Action(type: 'Dec')),
      effectKey: _effectKey,
    );
  }

  void _removeEffect([bool isDisposing = false]) {
    storeInstance().unregisterEffect(effectKey: _effectKey);
  }

  String getMessage(bool hasEffect) {
    return hasEffect
        ? "Effect added successfully.\nNow click on the [Async +] button and see it's performing additional action."
        : 'No special effect';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: _addEffectForAsyncInc,
                child: Text('Add Effect on AsyncInc action'),
              ),
              RaisedButton(
                onPressed: _removeEffect,
                child: Text('Remove effect'),
              )
            ],
          ),
          StreamBuilder<bool>(
              stream: select<SpecialEffectModel>('special-effect')
                  .map((model) => model.hasEffect),
              initialData: false,
              builder: (context, snapshot) {
                return Text(getMessage(snapshot.data),
                    style: TextStyle(fontSize: 20, color: Colors.white70));
              }),
        ],
      ),
    );
  }
}
