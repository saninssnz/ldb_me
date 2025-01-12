
import 'package:ldb_me/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> storeLoginModel(LoginModel model) async {
    final modelJson = loginModelToJson(model);
    await _prefs.setString('email_login_model', modelJson);
    await _prefs.setBool('is_logged_in', model.status ?? false);
  }

  static LoginModel? getLoginModel() {
    final storedJson = _prefs.getString('email_login_model');
    if (storedJson != null) {
      return loginModelFromJson(storedJson);
    }
    return null;
  }

  static bool isLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }
}