import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  // Listens in the widget tree; if user is signed in, homepage is returned. Otherwise, the login page is displayed.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  // Get UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser).uid;
  }

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in with email: $email";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String name, String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'name': name, 'email': email, 'uid': user.uid});
      return "Signed up with email: $email";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
