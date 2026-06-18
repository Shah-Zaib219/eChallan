import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  late SharedPreferences _prefs;

  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Save Session
  Future<void> saveUserSession({
    required String uid,
    required String role,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    await _prefs.setString('uid', uid);
    await _prefs.setString('role', role);
    await _prefs.setString('first_name', firstName);
    await _prefs.setString('last_name', lastName);
    await _prefs.setString('email', email);
  }

  // Getters
  String? get uid => _prefs.getString('uid');
  String? get role => _prefs.getString('role');
  String? get firstName => _prefs.getString('first_name');
  String? get lastName => _prefs.getString('last_name');
  String? get email => _prefs.getString('email');

  bool get isLoggedIn =>
      uid != null &&
      uid!.isNotEmpty &&
      role != null &&
      role!.isNotEmpty &&
      firstName != null &&
      firstName!.isNotEmpty;

  // Clear Session
  Future<void> clearSession() async {
    await _prefs.clear();
  }
}
