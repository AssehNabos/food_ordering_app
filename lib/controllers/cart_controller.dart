import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + (item.foodItem.price * item.quantity));

  void addToCart(FoodItem food) {
    final existingIndex = _items.indexWhere((item) => item.foodItem.id == food.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(foodItem: food));
    }
    notifyListeners();
  }

  void removeFromCart(FoodItem food) {
    final existingIndex = _items.indexWhere((item) => item.foodItem.id == food.id);
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
