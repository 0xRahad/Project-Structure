import 'package:logger/logger.dart';
import 'package:project_structure/core/utils/logging.dart';
import './model/session_model.dart';
import 'local_storage.dart';

class SessionManager {
  // Singleton instance
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();
  final LocalStorage _localStorage = LocalStorage();

  /// Saves user session data locally
  Future<void> setToken(SessionModel model) async {
    try {
      await _localStorage.setValue("token", model.token);
      await _localStorage.setValue("isLogin", true.toString());
      Logging.logInfo("User session saved successfully.");
    } catch (error) {
      Logging.logError("Failed to save user session: ${error.toString()}");
    }
  }

  Future<String> getToken() async {
    try {
      final token = await _localStorage.readValue("token");
      return token ?? "";
    } catch (e) {
      Logging.logError("Error fetching token: ${e.toString()}");
      return "";
    }
  }

  /// Clears user session data
  Future<void> clearSession() async {
    try {
      await _localStorage.clearValue("token");
      await _localStorage.clearValue("isLogin");
      Logging.logInfo("User session cleared successfully.");
    } catch (error) {
      Logging.logError("Failed to clear user session: ${error.toString()}");
    }
  }

  /// Checks if a valid user session exists
  Future<bool> isUserLoggedIn() async {
    try {
      final isLoginStored = await _localStorage.readValue("isLogin") == 'true';
      return isLoginStored;
    } catch (e) {
      Logging.logError("Error checking login status: ${e.toString()}");
      return false;
    }
  }
}
