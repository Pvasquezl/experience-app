import 'dart:convert';

import 'package:experience_app/core/constants.dart';
import 'package:experience_app/core/local_storage.dart';
import 'package:experience_app/features/explore/data/models/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalShoppingCartDataSource {
  final SharedPreferences _prefs;

  LocalShoppingCartDataSource({SharedPreferences? sharedPreferences})
    : _prefs = sharedPreferences ?? LocalStorage().prefs;

  Future<List<CartItemModel>> getCartItems() async {
    final shoppingCartItems = _prefs.getString(
      Constants.shoppingCartLocalStorageKey,
    );

    if (shoppingCartItems == null || shoppingCartItems.isEmpty) {
      return [];
    }

    final parsed = jsonDecode(shoppingCartItems);

    if (parsed is! List) {
      return [];
    }

    return parsed
        .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveCartItems(List<CartItemModel> items) async {
    await _prefs.setString(
      Constants.shoppingCartLocalStorageKey,
      jsonEncode(items.map((item) => item.toJson()).toList()),
    );
  }

  Future<int> getShoppingCartItemCount() async {
    final items = await getCartItems();
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  Future<void> addItem(CartItemModel item) async {
    final items = await getCartItems();
    final existingIndex = items.indexWhere(
      (existing) => existing.id == item.id,
    );

    if (existingIndex >= 0) {
      items[existingIndex] = items[existingIndex].copyWith(
        quantity: items[existingIndex].quantity + item.quantity,
      );
    } else {
      items.add(item);
    }

    await _saveCartItems(items);
  }

  Future<void> clearCart() async {
    await _saveCartItems([]);
  }
}
