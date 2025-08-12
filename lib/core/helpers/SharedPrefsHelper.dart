import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart'; // Import the constants file for keys

class SharedPrefsHelper {
  // Singleton instance for easy access
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  // Get SharedPreferences instance
  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  // Save Auth Token
  Future<void> saveToken(String token) async {
    final prefs = await _prefs();
    await prefs.setString(Constants.authTokenKey, token);
  }

  // Retrieve Auth Token
  Future<String?> getToken() async {
    final prefs = await _prefs();
    return prefs.getString(Constants.authTokenKey);
  }

  // Remove Auth Token
  Future<void> removeToken() async {
    final prefs = await _prefs();
    await prefs.remove(Constants.authTokenKey);
  }

  // Save User ID
  Future<void> saveUserId(int userId) async {
    final prefs = await _prefs();
    await prefs.setInt(Constants.userIdKey, userId);
  }

  // Retrieve User ID
  Future<int?> getUserId() async {
    final prefs = await _prefs();
    return prefs.getInt(Constants.userIdKey);
  }

  // Remove User ID
  Future<void> removeUserId() async {
    final prefs = await _prefs();
    await prefs.remove(Constants.userIdKey);
  }

  // Save onboarding completion status
  Future<void> saveOnboardingCompleted(bool completed) async {
    final prefs = await _prefs();
    await prefs.setBool(Constants.onboardingCompletedKey, completed);
  }

  // Retrieve onboarding completion status
  Future<bool> isOnboardingCompleted() async {
    final prefs = await _prefs();
    return prefs.getBool(Constants.onboardingCompletedKey) ?? false;
  }

  // Clear authentication data (e.g., on logout), but keep addresses
  Future<void> clearAuthData() async {
    final prefs = await _prefs();
    await prefs.remove(Constants.authTokenKey);
    await prefs.remove(Constants.userIdKey);
  }

  // Save Address List by User ID
  Future<void> saveAddressList(int userId, List<Map<String, dynamic>> addressList) async {
    final prefs = await _prefs();
    final addressJson = jsonEncode(addressList);
    await prefs.setString('${Constants.addressKey}_$userId', addressJson);
  }

  // Retrieve Address List by User ID
  Future<List<Map<String, dynamic>>> getAddressList(int userId) async {
    final prefs = await _prefs();
    final addressJson = prefs.getString('${Constants.addressKey}_$userId');
    if (addressJson != null) {
      try {
        final decoded = jsonDecode(addressJson) as List;
        return List<Map<String, dynamic>>.from(decoded.map((e) => Map<String, dynamic>.from(e)));
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // Clear Address List for a specific User ID
  Future<void> clearAddresses(int userId) async {
    final prefs = await _prefs();
    await prefs.remove('${Constants.addressKey}_$userId');
  }

  // Clear all preferences (if necessary)
  Future<void> clearAllData() async {
    final prefs = await _prefs();
    await prefs.clear();
  }
}