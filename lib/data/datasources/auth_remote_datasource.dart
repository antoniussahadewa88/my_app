import 'dart:convert';
import '../../core/network/api_client.dart';
import '../models/response/auth_reponse.dart';

//Mark:: ini seperti declare func okHttp atau interface berisi declare path pada Native
class AuthRemoteDatasource {
  final ApiClient api;
  AuthRemoteDatasource(this.api);

  Future<AuthResponse> login(String username, String password) async {
    final res = await api.post(
      '/auth/login',
      json: true,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (res.containsKey('accessToken')) {
      return AuthResponse.fromJson(res);
    }
    throw Exception('Login gagal: ${res.toString()}');
  }

  Future<void> register(Map<String, dynamic> body) async {
    await api.post(
      '/users/add',
      body: jsonEncode(body),
      json: true,
    );
  }
}