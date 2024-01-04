import 'package:flutter/material.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:logger/logger.dart';
import 'package:flutter_fe/auth/db_service.dart';

class AuthService  with ChangeNotifier{
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  final RequestUtil requestUtil = RequestUtil();

  Future<bool> login(String userName, String password) async {
    try {
      final response = await requestUtil.postUserLogin(userName, password);
      if (response.statusCode == 200) {
        await DatabaseProvider().saveToken(response.body);
        Logger().i('User logged in successfully');
        _isAuthenticated = true;
        notifyListeners(); // Értesítjük a hallgatókat a változásról
        return true;
      } else {
        Logger().i('Failed');
        return false;
      }
    } catch (error) {
      Logger().e('Error: $error');
      return false;
    }
  }
  
  void logout() {
    // Logikát ide írd a kijelentkezéshez, például token törléshez stb.
    // Például, amikor a kijelentkezés sikeres:
    _isAuthenticated = false;
    notifyListeners(); // Értesítjük a hallgatókat a változásról
  }
}