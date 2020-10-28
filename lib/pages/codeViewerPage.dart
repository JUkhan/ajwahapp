import 'package:flutter/material.dart' hide Action;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ajwah_bloc/ajwah_bloc.dart';
import '../widgets/treeViewWidget.dart';
import '../widgets/drawerWidget.dart';
import '../states/store.dart';

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
                      store.dispatch(CodeViewDataAction(res));
                    }
                  },
                  nodes: [
                    TreeNode(title: 'lib', children: [
                      TreeNode(title: 'api', children: [
                        TreeNode(title: 'api.dart', ref: 'api/api.md'),
                      ]),
                      TreeNode(title: 'models', children: [
                        TreeNode(title: 'todo', ref: 'models/todo.md'),
                        TreeNode(
                            title: 'todoActions', ref: 'models/todoActions.md'),
                      ]),
                      TreeNode(title: 'pages', children: [
                        TreeNode(title: 'todoPage', ref: 'pages/todoPage.md'),
                        TreeNode(
                            title: 'codeViewerPage',
                            ref: 'pages/codeViewerPage.md'),
                      ]),
                      TreeNode(title: 'servives', children: [
                        TreeNode(
                            title: 'todoService',
                            ref: 'services/todoService.md'),
                      ]),
                      TreeNode(title: 'states', children: [
                        TreeNode(title: 'store', ref: 'states/store.md'),
                        TreeNode(
                            title: 'todoState', ref: 'states/todoState.md'),
                      ]),
                      TreeNode(title: 'widgets', children: [
                        TreeNode(
                            title: 'drawerWidget',
                            ref: 'widgets/drawerWidget.md'),
                        TreeNode(title: 'error', ref: 'widgets/errors.md'),
                        TreeNode(title: 'loading', ref: 'widgets/loading.md'),
                        TreeNode(
                            title: 'titleWidget',
                            ref: 'widgets/titleWidget.md'),
                        TreeNode(title: 'todoItem', ref: 'widgets/todoItem.md'),
                        TreeNode(title: 'toolbar', ref: 'widgets/toolbar.md'),
                        TreeNode(
                            title: 'treeViewWidget',
                            ref: 'widgets/treeViewWidget.md'),
                      ]),
                      TreeNode(title: 'main', ref: 'main.md')
                    ])
                  ],
                )),
            StreamBuilder<String>(
                stream: store.actions
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
