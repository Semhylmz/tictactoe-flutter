import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictactoe/core/services/user_service.dart';
import 'package:tictactoe/features/user/data/models/user_model.dart';

class UserRepository {
  final UserService userAuthService;

  UserRepository(this.userAuthService);

  User? get currentUser => userAuthService.currentUser;

  Future<User?> signInAnonymously() async {
    return await userAuthService.signInAnonymously();
  }

  Future<void> saveUser(UserModel user) async {
    await userAuthService.saveUser(user);
  }

  Future<UserModel?> getUser(String userUuid) async {
    return await userAuthService.getUser(userUuid);
  }
}
