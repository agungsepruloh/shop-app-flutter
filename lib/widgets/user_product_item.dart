import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/products_provider.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  UserProductItem({this.id, this.title, this.imageURL});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.teal,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .deleteProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
