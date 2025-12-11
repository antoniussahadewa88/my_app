import '../repositories/auth_repository.dart';
import '../../data/models/response/auth_reponse.dart';

//Mark :: Ini seperti Usecase pada Native Code.
class LoginUsecase {
  final AuthRepository repo;
  LoginUsecase(this.repo);

  Future<AuthResponse> call(String username, String password) {
    return repo.login(username, password);
  }
}