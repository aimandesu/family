import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  bool? isTheColorDark;

  bool? get isColorDark => isTheColorDark;

  Future<void> isDark() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isTheColorDark = pref.getBool("UserTheme");
  }
}
