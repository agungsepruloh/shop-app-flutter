import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/widgets/user_product_item.dart';
import 'package:shop_app_flutter/providers/products_provider.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = 'user_products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) => UserProductItem(
            id: productsData.items[index].id,
            title: productsData.items[index].name,
            imageURL: productsData.items[index].imageURL,
          ),
        ),
      ),
    );
  }
}
