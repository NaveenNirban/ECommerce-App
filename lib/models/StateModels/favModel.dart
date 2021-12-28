import 'package:flutter/material.dart';

class FavModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final Set<int> _items = <int>{};

  /// An unmodifiable view of the items in the cart.
  //UnmodifiableListView<int> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(int id) {
    _items.add(id);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(int id) {
    _items.remove(id);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool getFav(int id) {
    if (_items.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
