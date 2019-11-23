import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/providers/orders.dart';
import 'package:shop_app_flutter/providers/products_provider.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/orders_screen.dart';
import 'package:shop_app_flutter/screens/user_products_screen.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:shop_app_flutter/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // start using multi provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // SECOND way of using ChangeNotifierProvider
          // Using builder return the provider of listened data
          // ChangeNotifierProvider(
          // builder: (context) => ProductsProvider(),
          // but when using the builder, it will tak more risk of bug
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.white,
        ),
        home: ProductsOverviewScreen(title: 'Shop App'),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// // take the option value / filter from here
// enum FilterOptions { Favorites, All }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // var productsData = Provider.of<ProductsProvider>(context);
//     var isAllProducts = true;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: <Widget>[
//           PopupMenuButton(
//             onSelected: (FilterOptions selectedValue) {
//               if (selectedValue == FilterOptions.Favorites) {
//                 setState(() {
//                   isAllProducts = false;
//                 });
//                 // productsData.showFavoritesOnly();
//               } else {
//                 setState(() {
//                   isAllProducts = true;
//                 });
//                 // productsData.showAllProducts();
//               }
//             },
//             icon: Icon(Icons.more_vert),
//             itemBuilder: (_) => [
//               PopupMenuItem(
//                 child: Text('Only Favorites'),
//                 // the value choose from ENUM on the top of class
//                 value: FilterOptions.Favorites,
//               ),
//               PopupMenuItem(
//                 child: Text('All Products'),
//                 // the value choose from ENUM on the top of class
//                 value: FilterOptions.All,
//               )
//             ],
//           ),
//         ],
//       ),
//       // for filter only favorite products or all products
//       body: ProductsOverviewScreen(isAllProducts),
//     );
//   }
// }
