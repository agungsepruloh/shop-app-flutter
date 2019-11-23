import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/widgets/cart_item.dart';
import 'package:shop_app_flutter/providers/cart.dart' show Cart;
import 'package:shop_app_flutter/providers/orders.dart';
import 'package:shop_app_flutter/providers/products_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  FlatButton(
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                    onPressed: () {
                      if (cart.totalAmount > 0) {
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        cart.clearCart();
                        Provider.of<ProductsProvider>(context)
                            .items
                            .forEach((product) => product.clearQuantity());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) => CartItem(
                id: cart.items.values.toList()[index].id,
                name: cart.items.values.toList()[index].title,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                productId: cart.items.keys.toList()[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
