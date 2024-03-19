import 'dart:developer';
import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/models.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserRepository implements AbstractAuthRepository {
  UserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future login({required String password, required String email}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        throw 'Wrong password provided for that user.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        log('INVALID LOGIN CREDENTIALS');
        throw 'Invalid login credentials.';
      } else {
        log('$e');
        throw e.code;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> registration(
    UserModel userModel,
    String password,
  ) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

      userModel = userModel.copyWith(uid: user.user?.uid);

      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        throw 'The account already exists for that email.';
      } else {
        log('$e');
        throw e.code;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      log(googleUser.toString());

      if (googleUser == null) {
        throw 'You canceled authentication with Google';
      } else {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final userDoc = usersCollection.doc(userCredential.user?.uid);
        final existingDoc = await userDoc.get();
        if (!existingDoc.exists) {
          UserModel myUser = UserModel.userEmpty.copyWith(
              createAt: DateFormat.yMMMMd().format(DateTime.now()),
              email: userCredential.user?.email,
              uid: userCredential.user?.uid,
              username: userCredential.user?.displayName,
              imageUrl: userCredential.user?.photoURL);
          await setUserData(myUser);
        }
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw e.toString();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference referenceStorageRef =
          FirebaseStorage.instance.ref().child('$userId//PP/${userId}_load');

      await referenceStorageRef.putFile(imageFile);
      String url = await referenceStorageRef.getDownloadURL();
      await usersCollection.doc(userId).update({UserModelField.imageUrl: url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signInWithApple() async {
    try {
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );
      log(credential.toString());
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserInfo(UserModel userModel) async {
    try {
      await usersCollection.doc(userModel.uid).update(userModel.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(UserModel userModel) async {
    try {
      await usersCollection.doc(userModel.uid).set(userModel.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> getUserById({required String userId}) async {
    try {
      return usersCollection
          .doc(userId)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> following({
    required UserModel userModel,
    required UserModel currentUser,
  }) async {
    try {
      final userDoc = usersCollection.doc(userModel.uid);
      final userData = await userDoc.get();

      final List<dynamic> followersData = userData.data()?['followers'] ?? [];
      final List<UserModel> followers = followersData
          .map((followerData) => UserModel.fromJson(followerData))
          .toList();

      if (!followers.contains(currentUser)) {
        followers.add(currentUser);
      } else {
        followers.remove(currentUser);
      }
      userModel = userModel.copyWith(followers: followers);

      final followersJson =
          followers.map((follower) => follower.toJson()).toList();

      await userDoc.update({'followers': followersJson});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> isFollowed(
      {required UserModel userModel, required String currentUserId}) async {
    try {
      final userDoc = usersCollection.doc(userModel.uid);
      bool isLiked = false;
      final userData = await userDoc.get();

      final List<dynamic> followersData = userData.data()?['followers'] ?? [];
      final List<UserModel> followers = followersData
          .map((followerData) => UserModel.fromJson(followerData))
          .toList();

      if (followersData.contains(currentUserId)) {
        isLiked = true;
      } else {
        isLiked = false;
      }
      userModel = userModel.copyWith(followers: followers);

      final followersJson =
          followers.map((follower) => follower.toJson()).toList();

      await userDoc.update({'followers': followersJson});
      return isLiked;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getFollowersCurrentUser(
      {required UserModel userModel}) async {
    try {
      final userDoc = usersCollection.doc(userModel.uid);
      final userData = await userDoc.get();
      final List<UserModel> followers =
          List<UserModel>.from(userData.data()?['followers'] ?? []);
      return followers;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> searchUser({
    required String text,
    required UserModel userModel,
  }) async {
    try {
      final List<UserModel> searchResults = [];

      final List<UserModel> followers = userModel.followers;

      for (final follower in followers) {
        if (follower.username.toLowerCase().contains(text.toLowerCase())) {
          searchResults.add(follower);
        }
      }

      return searchResults;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
