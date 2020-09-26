import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';

class ExportStateWidget extends StatelessWidget {
  const ExportStateWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _txtStyle = Theme.of(context).textTheme;
    return StreamBuilder(
      stream: storeInstance().exportState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text.rich(
              TextSpan(text: 'Export States\n', children: [
                TextSpan(
                    text:
                        'action:${snapshot.data[0]} \nstates:${snapshot.data[1]}',
                    style: _txtStyle.subtitle1)
              ]),
              textAlign: TextAlign.center,
              style: _txtStyle.headline3,
            ),
          );
        }
        return Container();
      },
    );
  }
}
