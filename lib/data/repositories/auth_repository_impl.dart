import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/response/auth_reponse.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<AuthResponse> login(String username, String password) {
    return remote.login(username, password);
  }

  @override
  Future<void> register(Map<String, dynamic> body) {
    return remote.register(body);
  }
}
