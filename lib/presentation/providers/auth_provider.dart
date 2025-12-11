import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/models/response/auth_reponse.dart';

//Mark :: Ini seperti ViewModel pada Native Code.
class AuthProvider extends ChangeNotifier{ 
  
  final LoginUsecase loginUsecase;
  final FlutterSecureStorage storage;

  AuthProvider({ required this.loginUsecase, required this.storage });

  bool loading = false;
  String? token;
  String? error;

  AuthResponse? authData;
  

  Future<bool> login(String username, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final AuthResponse result = await loginUsecase(username, password);

      authData = result;
      token = result.accessToken;
      await storage.write(key: 'auth_token', value: result.accessToken);
      loading = false;
      notifyListeners();
      print(result.username);
      print(result.firstName);
      return true;
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    authData = null;
    token = null;
    await storage.delete(key: 'auth_token');
    notifyListeners();
  }

  Future<void> tryLoadToken() async {
    final t = await storage.read(key: 'auth_token');
    token = t;
    notifyListeners();
  }
}