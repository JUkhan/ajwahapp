import 'package:flutter/material.dart' hide Action;
import '../widgets/specialEffectWidget.dart';
import '../widgets/counterWidget.dart';
import '../widgets/exportStateWidget.dart';
import '../widgets/stateOnDemandWidget.dart';
import '../widgets/drawerWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic ajwah_bloc'),
      ),
      drawer: DrawerWidget(),
      body: Container(
          child: Column(
        children: <Widget>[
          StateOnDemandWidget(),
          CounterWidget(),
          SpecialEffectWidget(),
          ExportStateWidget(),
        ],
      )),
    );
  }
}
