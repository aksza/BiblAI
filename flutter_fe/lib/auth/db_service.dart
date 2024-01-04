
import 'package:flutter/material.dart';
import 'package:flutter_fe/auth/login_or_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier{
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';
  int _userId = 0;

  String get token => _token;
  int get userId => _userId;

  Future<void> saveUserId(int userId) async{
    SharedPreferences value = await _pref;
    value.setInt('userId', userId);
    notifyListeners();
  }

  Future<int> getUserId() async {
    SharedPreferences value = await _pref;

    if(value.containsKey('userId')){
      int data = value.getInt('userId')!;
      _userId = data;
      notifyListeners();
      return data;

    }else{
      _userId = 0;
      notifyListeners();
      return 0;
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if(value.containsKey('token')){
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;

    }else{
      _token = '';
      notifyListeners();
      return '';
    }
  }
  void logOut(BuildContext context) async{
    final value = await _pref;

    value.clear();

    Navigator.pushReplacement(context as BuildContext , MaterialPageRoute(builder: (context) => LoginOrRegister()));
  }
}