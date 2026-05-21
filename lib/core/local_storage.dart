import 'dart:convert';

import 'package:experience_app/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late final SharedPreferences prefs;
  static final LocalStorage _instance = LocalStorage._internal();

  LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    const cartObject = [
      {'id': 1, 'name': 'Experience 1', 'price': 100.0, 'quantity': 2},
      {'id': 2, 'name': 'Experience 2', 'price': 50.0, 'quantity': 1},
      {'id': 3, 'name': 'Experience 3', 'price': 75.0, 'quantity': 3},
    ];
    await prefs.setString(
      Constants.shoppingCartLocalStorageKey,
      jsonEncode(cartObject),
    );
  }
}
