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
    if (!prefs.containsKey(Constants.shoppingCartLocalStorageKey)) {
      await prefs.setString(
        Constants.shoppingCartLocalStorageKey,
        jsonEncode(<Map<String, dynamic>>[]),
      );
    }
  }
}
