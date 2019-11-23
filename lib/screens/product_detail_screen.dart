import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = 'product-detail';
  // final String title;
  // ProductDetailScreen({this.title});

  @override
  Widget build(BuildContext context) {
    // the id come from product item file
    final productId = ModalRoute.of(context).settings.arguments
        as String; // is the product id!

    // READ THIS!
    // when we set the listen become false, the widget only will be update when we run the page
    // so it will make the apps easier and lighter
    // because we don't need rebuild the whole widget when the products provider changes

    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    // .items
    // .firstWhere((product) => product.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                loadedProduct.imageURL,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
