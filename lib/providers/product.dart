// so we can using required for the fields
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String imageURL;
  final double price;
  bool isFavorit;
  int quantity;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.imageURL,
    @required this.price,
    this.isFavorit = false,
    this.quantity = 0,
  });

  void favoriteToggleState() {
    isFavorit = !isFavorit;
    notifyListeners();
  }

  void addQuantity() {
    quantity += 1;
    notifyListeners();
  }

  void clearQuantity() {
    quantity = 0;
    notifyListeners();
  }

  void subQuantity() {
    quantity -= 1;
    notifyListeners();
  }
}
