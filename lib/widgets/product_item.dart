import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:shop_app_flutter/providers/product.dart';
import 'package:shop_app_flutter/providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String name;
  // final String imageURL;

  // ProductItem({this.id, this.name, this.imageURL});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(2.5),
      child: GridTile(
        child: GestureDetector(
          child: Image.asset(
            product.imageURL,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          // using CONSUMER because we use it for a specific widget
          // we don't need to rebuild the entire widget
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              // child is using when we need to rebuild the entire widget except a specific widget that is inside the child
              icon: Icon(
                product.isFavorit ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.favoriteToggleState();
              },
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          subtitle: Consumer<Product>(
            builder: (_, prod, ch) => Text('${prod.quantity} x'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.addQuantity();
              cart.addItem(product.id, product.price, product.name);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product Added to Cart!'),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      if (product.quantity > 0) {
                        product.subQuantity();
                      }
                      cart.removeSingleItem(product.id);
                    },
                    textColor: Colors.blue,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
