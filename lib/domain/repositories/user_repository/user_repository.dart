import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';

class UserRepository implements AbstractAuthRepository {
  FirebaseAuth _firebaseAuth;
  final Dio dio;

  UserRepository({
    FirebaseAuth? firebaseAuth,
    required this.dio,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final userCollection = FirebaseFirestore.instance.collection('users');

  // Future<void> addUserDetails(UserModel userModel) async {
  //   try {
  //     if (userModel.uid.isNotEmpty) {
  //       await userCollection.doc(userModel.uid).set(userModel.toJson());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

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
  Future<void> registration(UserModel userModel) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
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
  Future<void> singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw 'You canceled authentication with Google';
      } else {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        //final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw e.toString();
    } catch (e) {
      log(e.toString());
      throw e.toString();
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
      DateTime time = DateTime.now();
      File imageFile = File(file);
      Reference referenceStorageRef = FirebaseStorage.instance
          .ref()
          .child('$userId//PP/${userId}_${time}_load');

      await referenceStorageRef.putFile(imageFile);
      String url = await referenceStorageRef.getDownloadURL();
      await userCollection.doc(userId).update({UserModelField.imageUrl: url});
      return url;
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<void> singInWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserInfo(UserModel userModel) async {
    try {
      await userCollection.doc(userModel.uid).update(userModel.toJson());
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
