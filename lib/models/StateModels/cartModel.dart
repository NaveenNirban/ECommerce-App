import 'dart:collection';

import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final Set<Product> _items = <Product>{};

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  double get totalPrice {
    double total = 0.0;
    for (var element in _items) {
      total += element.price;
    }

    return (total) - ((total / 5) + (total % 5));
  }

  double get get10PercentDiscount {
    return (totalPrice) - ((totalPrice / 10) + (totalPrice % 10));
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Product _product) {
    _items.add(_product);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
