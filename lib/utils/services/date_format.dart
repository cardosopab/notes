import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateStateNotifier extends StateNotifier<int> {
  late final SharedPreferences _prefs;
  DateStateNotifier(int dateFormat) : super(dateFormat) {
    _loadFormat();
  }

  static const _kDateFormatKey = 'dateFormat';

  void saveFormat(int value) {
    state = value;
    _prefs.setInt(_kDateFormatKey, value);
  }

  Future<void> _loadFormat() async {
    _prefs = await SharedPreferences.getInstance();
    final formatInt = _prefs.getInt(_kDateFormatKey);
    if (formatInt != null) {
      state = formatInt;
    } else {
      _prefs.setInt(_kDateFormatKey, 0);
    }
  }
}

final dateStateNotifierProvider = StateNotifierProvider<DateStateNotifier, int>((ref) {
  return DateStateNotifier(0);
});
