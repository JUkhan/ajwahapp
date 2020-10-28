import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../services/todoService.dart';

class Loading extends HookWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loading = useStream(loading$, initialData: false);

    return Container(
      alignment: Alignment.center,
      child: loading.data ? CircularProgressIndicator() : null,
    );
  }
}
