import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/providers/products_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String productId;

  CartItem({this.id, this.name, this.price, this.quantity, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (dismissDirection) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are You Sure?'),
            content: Text('Do you want to remove the item from the cart'),
            actions: <Widget>[
              FlatButton(
                  child: Text('No', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              FlatButton(
                child: Text('Yes', style: TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
        Provider.of<ProductsProvider>(context)
            .findById(productId)
            .clearQuantity();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(name),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
