import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/orders.dart' show Orders;
import 'package:shop_app_flutter/widgets/order_item.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'Orders Screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(
          order: orderData.orders[index],
        ),
      ),
    );
  }
}
