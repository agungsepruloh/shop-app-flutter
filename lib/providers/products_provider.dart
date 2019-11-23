import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'P1',
        name: 'Add Color Illustration',
        description: 'An Add Color Illustration',
        price: 200,
        imageURL: 'assets/images/undraw_add_color.png'),
    Product(
        id: 'P2',
        name: 'Certificate Illustration',
        description: 'A Certificate Illustration',
        price: 150,
        imageURL: 'assets/images/undraw_certificate.png'),
    Product(
        id: 'P3',
        name: 'Agree Illustration',
        description: 'An Agree Illustration',
        price: 170,
        imageURL: 'assets/images/undraw_agree.png'),
    Product(
        id: 'P4',
        name: 'Location Search Illustration',
        description: 'A Location Search Illustration',
        price: 180,
        imageURL: 'assets/images/undraw_location_search.png'),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly == true) {
    // filter for show only favorite items
    // return _items.where((productItem) => productItem.isFavorit).toList();
    // }
    return [..._items];
  }

  List<Product> get favoritesOnly {
    return _items.where((productItem) => productItem.isFavorit).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAllProducts() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(productId) {
    return _items.firstWhere((product) => product.id == productId);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      name: product.name,
      description: product.description,
      price: product.price,
      imageURL: product.imageURL,
    );
    _items.add(newProduct);
    // _items.add(value);
    // _items.insert(0, newProduct); // if you want the product insert at the start of the list
    notifyListeners();
  }

  void updateProduct(String productId, Product newProductData) {
    final productIndex =
        _items.indexWhere((product) => product.id == productId);
    _items[productIndex] = newProductData;
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
