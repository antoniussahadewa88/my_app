import '../../data/models/response/auth_reponse.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String username, String password);
  Future<void> register(Map<String, dynamic> body);
}