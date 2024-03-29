import 'package:firebase_auth/firebase_auth.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';

abstract interface class AbstractAuthRepository {
  Future<UserModel> registration(UserModel userModel, String password);
  Future<void> login({
    required String password,
    required String email,
  });

  Future<void> signOut();

  Future<void> setUserData(UserModel userModel);

  Stream<User?> get user;

  Future<void> forgotPassword({required String email});

  Future<void> signInWithGoogle();

  Future<void> updateUserInfo(
    UserModel userModel,
  );

  Future<void> following(
      {required UserModel userModel, required UserModel currentUser});

  Future<List<UserModel>> getFollowersCurrentUser(
      {required UserModel userModel});

  Future<List<UserModel>> searchUser(
      {required String text, required UserModel userModel});

  Future<UserModel> getUserById({required String userId});

  Future<String> uploadPicture(String file, String userId);

  Future<bool> isFollowed(
      {required UserModel userModel, required String currentUserId});

  Future<void> signInWithApple();
}
