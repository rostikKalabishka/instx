import 'package:firebase_auth/firebase_auth.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';

abstract interface class AbstractAuthRepository {
  Future<void> registration(UserModel userModel);
  Future login({
    required String password,
    required String email,
  });

  Future<void> signOut();

  // Future<void> addUserDetails(UserModel userModel);

  Stream<User?> get user;

  Future<void> forgotPassword({required String email});

  Future<void> signInWithGoogle();

  Future<void> updateUserInfo(UserModel userModel);

  Future<String> uploadPicture(String file, String userId);

  Future<void> signInWithApple();
}
