import 'package:flutter/material.dart';

class TreeViewWidget<T> extends StatefulWidget {
  final Icon collapsedIcon;
  final Icon expandedIcon;
  final Icon leafIcon;
  final List<TreeNode<T>> nodes;
  final TreeNodeOnTapCallback<T> onTap;

  const TreeViewWidget({
    Key key,
    this.nodes,
    this.onTap,
    Icon collapsedIcon,
    Icon expandedIcon,
    Icon leafIcon,
  })  : collapsedIcon = collapsedIcon ?? const Icon(Icons.folder),
        expandedIcon = expandedIcon ?? const Icon(Icons.folder_open),
        leafIcon = leafIcon ?? const Icon(Icons.code),
        super(key: key);

  @override
  _TreeViewWidgetState<T> createState() => _TreeViewWidgetState<T>();
}

class _TreeViewWidgetState<T> extends State<TreeViewWidget<T>> {
  _TreeNodeWidgetState _selectedWidget;
  void setSelectedNode(_TreeNodeWidgetState selectedWidget) {
    if (selectedWidget == _selectedWidget) {
      return;
    }
    _selectedWidget?.refresh();
    _selectedWidget = selectedWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var item in widget.nodes)
          TreeNodeWidget<T>(
            parent: this,
            treeNode: item,
            collapsedIcon: widget.collapsedIcon,
            expandedIcon: widget.expandedIcon,
            onTap: widget.onTap,
            leafIcon: widget.leafIcon,
          ),
      ],
    );
  }
}

class TreeNodeWidget<T> extends StatefulWidget {
  final _TreeViewWidgetState parent;
  final TreeNode treeNode;
  final Icon collapsedIcon;
  final Icon expandedIcon;
  final TreeNodeOnTapCallback<T> onTap;
  final Icon leafIcon;
  TreeNodeWidget({
    Key key,
    this.parent,
    this.treeNode,
    this.leafIcon,
    this.collapsedIcon,
    this.expandedIcon,
    this.onTap,
  }) : super(key: key);

  @override
  _TreeNodeWidgetState<T> createState() => _TreeNodeWidgetState<T>();
}

class _TreeNodeWidgetState<T> extends State<TreeNodeWidget<T>> {
  TreeNode node;
  @override
  void initState() {
    super.initState();
    node = widget.treeNode;
  }

  Icon getIcon() {
    if (node.hasChildren) {
      return node.isExpanded ? widget.expandedIcon : widget.collapsedIcon;
    }
    return widget.leafIcon;
  }

  @override
  Widget build(BuildContext context) {
    if (node.hasChildren && node.isExpanded) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _getListTile(),
          for (var item in node.children)
            Container(
              padding: EdgeInsets.only(left: node.emptySpacy + 20),
              child: TreeNodeWidget<T>(
                parent: widget.parent,
                treeNode: item..emptySpacy += 20,
                collapsedIcon: widget.collapsedIcon,
                expandedIcon: widget.expandedIcon,
                onTap: widget.onTap,
                leafIcon: widget.leafIcon,
              ),
            ),
        ],
      );
    }
    return _getListTile();
  }

  void refresh() {
    node.selected = false;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _getListTile() => ListTile(
        title: Text(node.title),
        subtitle: (node.subTitle is String) ? Text(node.subTitle) : null,
        leading: getIcon(),
        onTap: () {
          if (node.hasChildren) {
            node.isExpanded = !node.isExpanded;
          } else {
            node.selected = !node.selected;
            widget.parent.setSelectedNode(this);
          }
          if (widget.onTap is TreeNodeOnTapCallback<T>) {
            widget.onTap(context, node, this);
          }
          setState(() {});
        },
        selected: node.selected,
      );
}

typedef TreeNodeOnTapCallback<T> = void Function(BuildContext context,
    TreeNode<T> item, _TreeNodeWidgetState<T> treeNodeWidget);

class TreeNode<T> {
  T ref;
  double emptySpacy;
  String title;
  String subTitle;
  bool isExpanded;
  bool hasChildren;
  bool selected;
  List<TreeNode<T>> children;
  TreeNode({
    @required this.title,
    this.ref,
    this.subTitle,
    this.selected = false,
    this.isExpanded = false,
    this.hasChildren = false,
    this.children = const [],
    this.emptySpacy = 0,
  }) {
    if (this.children.isNotEmpty) {
      this.hasChildren = true;
    }
  }
}
