import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/products_provider.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/widgets/product_item.dart';
import 'package:shop_app_flutter/widgets/badge.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';

class ProductsOverviewScreen extends StatefulWidget {
  final String title;
  ProductsOverviewScreen({this.title});

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

enum FilterOptions { Favorites, All }

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // this variable placed here becausee if we place it in the build method, this variable will always get the rebuild and the value will be always true
  var _isAllProducts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOptions.Favorites) {
                    _isAllProducts = false;
                    // productsData.showFavoritesOnly();
                  } else {
                    _isAllProducts = true;
                    // productsData.showAllProducts();
                  }
                },
              );
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                // the value choose from ENUM on the top of class
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All Products'),
                // the value choose from ENUM on the top of class
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      // for filter only favorite products or all products
      body: ProductsGrid(
        showAllProducts: _isAllProducts,
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final bool showAllProducts;
  ProductsGrid({this.showAllProducts});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        // do filtering for all products or favorites only
        // the different is for the getter function
        showAllProducts ? productsData.items : productsData.favoritesOnly;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return
            // ChangeNotifierProvider(
            // builder: (context) => products[index],
            // SECOND way of using ChangeNotifierProvider
            // using the first method is more possible for get a bug
            ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(
              // id: products[index].id,
              // name: products[index].name,
              // imageURL: products[index].imageURL,
              ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
    );
  }
}
