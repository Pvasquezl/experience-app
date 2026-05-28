import 'dart:convert';

import 'package:experience_app/core/constants.dart';
import 'package:experience_app/core/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalShoppingCartDataSource {
  final SharedPreferences _prefs;

  LocalShoppingCartDataSource({SharedPreferences? sharedPreferences})
    : _prefs = sharedPreferences ?? LocalStorage().prefs;

  Future<int> getShoppingCartItemCount() async {
    final shoppingCartItems = _prefs.getString(
      Constants.shoppingCartLocalStorageKey,
    );

    if (shoppingCartItems == null || shoppingCartItems.isEmpty) {
      return 0;
    }

    final parsed = jsonDecode(shoppingCartItems);

    if (parsed is List) {
      return parsed.length;
    }

    return 0;
  }
}
