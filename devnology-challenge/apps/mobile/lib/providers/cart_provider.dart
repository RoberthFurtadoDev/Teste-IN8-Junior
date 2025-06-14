// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import 'package:mobile/models/cart_item.dart';
import 'package:mobile/models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalItems {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (double.tryParse(cartItem.product.preco) ?? 0.0) * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Apenas aumenta a quantidade
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // Adiciona um novo item
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
        ),
      );
    }
    // Notifica os "ouvintes" (widgets) que o estado mudou
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
