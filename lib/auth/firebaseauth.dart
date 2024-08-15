import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static const String _usersPath = "users";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static Stream<User?> StreamIsLoggedIn() {
    print("object");
    return FirebaseAuth.instance.userChanges();
  }

  static User? isLoggedIn() {
    print("object");
    return FirebaseAuth.instance.currentUser;
  }

  static Future<bool> createUser(
      String emailAddress, String password, String displayName) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? user = credential.user;
      if (user != null) {
        await user.updateProfile(displayName: displayName);
        await _db.collection(_usersPath).doc(user.uid).set({
          "email": emailAddress,
          "displayName": displayName,
          "uid": user.uid
        });

        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        print('User created: ${user!.displayName}');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: ${e.code}.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  static Future<String?> logInByEmailPassword(
      String emailAddress, String password) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (result.user != null) {
        return 'success';
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return "Sign In Failed";
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    print("logout");
  }
}
