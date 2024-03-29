import 'package:flutter/material.dart';

import 'package:shop_app_flutter/screens/orders_screen.dart';
import 'package:shop_app_flutter/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Happy Shop'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shops'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
