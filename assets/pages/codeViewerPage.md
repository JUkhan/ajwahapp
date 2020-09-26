**codeViewerPage.dart**

```dart
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ajwah_bloc/ajwah_bloc.dart';
import '../widgets/treeViewWidget.dart';
import '../widgets/drawerWidget.dart';

class CodeViewDataAction extends Action {
  final String data;
  CodeViewDataAction(this.data);
}

class CodeViewerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Code Viewer')),
      drawer: DrawerWidget(),
      body: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 200,
                child: TreeViewWidget<String>(
                  onTap: (context, item, tree) async {
                    if (item.ref?.isNotEmpty ?? false) {
                      var res =
                          await rootBundle.loadString('assets/' + item.ref);
                      dispatch(CodeViewDataAction(res));
                    }
                  },
                  nodes: [
                    TreeNode(title: 'lib', children: [
                      TreeNode(title: 'models', children: [
                        TreeNode(
                            title: 'asyncData', ref: 'models/asyncData.md'),
                        TreeNode(
                            title: 'specialEffectModel',
                            ref: 'models/specialEffectModel.md'),
                      ]),
                      TreeNode(title: 'pages', children: [
                        TreeNode(title: 'homePage', ref: 'pages/homePage.md'),
                        TreeNode(
                            title: 'codeViewerPage',
                            ref: 'pages/codeViewerPage.md'),
                      ]),
                      TreeNode(title: 'states', children: [
                        TreeNode(
                            title: 'counterState',
                            ref: 'states/counterState.md'),
                        TreeNode(
                            title: 'specialEffectState',
                            ref: 'states/specialEffectState.md'),
                        TreeNode(
                            title: 'themeState', ref: 'states/themeState.md')
                      ]),
                      TreeNode(title: 'widgets', children: [
                        TreeNode(
                            title: 'counterWidget',
                            ref: 'widgets/counterWidget.md'),
                        TreeNode(
                            title: 'drawerWidget',
                            ref: 'widgets/drawerWidget.md'),
                        TreeNode(
                            title: 'dynamicWidget',
                            ref: 'widgets/dynamicWidget.md'),
                        TreeNode(
                            title: 'exportStateWidget',
                            ref: 'widgets/exportStateWidget.md'),
                        TreeNode(
                            title: 'specialEffectWidget',
                            ref: 'widgets/specialEffectWidget.md'),
                        TreeNode(
                            title: 'stateOnDemandWidget',
                            ref: 'widgets/stateOnDemandWidget.md'),
                        TreeNode(
                            title: 'treeViewWidget',
                            ref: 'widgets/treeViewWidget.md')
                      ]),
                    ])
                  ],
                )),
            StreamBuilder<String>(
                stream: storeInstance()
                    .dispatcher
                    .where((action) => action is CodeViewDataAction)
                    .map((action) => (action as CodeViewDataAction).data),
                initialData: '',
                builder: (context, snapshot) {
                  if (snapshot.data.isNotEmpty) {
                    return Expanded(
                      child: Markdown(
                        data: snapshot.data,
                        //shrinkWrap: true,
                      ),
                    );
                  }
                  return Container(
                    child: Text('Choose a file from left menu'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

```
