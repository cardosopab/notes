import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOrderNotifier extends StateNotifier<int> {
  late final SharedPreferences _prefs;
  ListOrderNotifier(int listOrder) : super(listOrder) {
    _loadOrder();
  }

  void saveOrder(int value) async {
    state = value;
    await _prefs.setInt(_kListOrderKey, value);
  }

  static const _kListOrderKey = 'listOrder';

  Future<void> _loadOrder() async {
    _prefs = await SharedPreferences.getInstance();
    final orderInt = _prefs.getInt(_kListOrderKey);
    if (orderInt != null) {
      state = orderInt;
    } else {
      _prefs.setInt(_kListOrderKey, 0);
    }
  }
}

final listOrderStateNotifierProvider = StateNotifierProvider<ListOrderNotifier, int>((ref) {
  return ListOrderNotifier(0);
});
