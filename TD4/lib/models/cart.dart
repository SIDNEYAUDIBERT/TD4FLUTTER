import 'package:flutter/cupertino.dart';
import 'package:jpp/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart extends ChangeNotifier {

  List<CartItem> _items = [];

  double get price {
    if(_items.isEmpty) return 0;
    else return _items.map((e) => e.quantity * e.pizza.price)
        .reduce((value, element) => value + element);
  }

  int get totalItems {
    return _items.length;
  }

  int get totalItemsWithQuantity {
    if(_items.isEmpty) return 0;
    else return _items.map((e) => e.quantity)
        .reduce((value, element) => value + element);
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);
    if (index == -1) {
      // Ajout
      _items.add(CartItem(pizza));
    } else {
      // Incrémente la quantité
      CartItem item = _items[index];
      item.quantity++;
    }
    notifyListeners();
  }

  removeProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);
    if (index != -1) {
      // Suppression
      _items.removeAt(index);
    }
    pizza.quantity -= 1;
    notifyListeners();
  }

  int findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }

  void removeQuantity(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if(_items[index].quantity == 1) removeProduct(pizza);
    else _items[index].quantity--;
    notifyListeners();
  }

  void addQuantity(Pizza pizza) {
    _items[findCartItemIndex(pizza.id)].quantity++;
    notifyListeners();
  }
}
