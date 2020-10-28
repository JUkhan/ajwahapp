import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text('Reactive Programming'),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: AssetImage('assets/launcher.png'),
              )),
          getTile(
            context,
            'Todos',
            Icons.home,
            '/',
          ),
          Divider(),
          getTile(
            context,
            'Code View',
            Icons.book,
            '/code',
          ),
        ],
      ),
    );
  }

  ListTile getTile(
      BuildContext context, String title, IconData icon, String navigateTo,
      [bool isSelected = false]) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {
        if (navigateTo.isEmpty) return;
        Navigator.pushReplacementNamed(context, navigateTo);
      },
      selected: isSelected,
    );
  }
}
