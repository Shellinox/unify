// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethod {
  final FirebaseAuth _auth;
  FirebaseAuthMethod(this._auth);


  // check if user is logged in or not
  Stream<User?> get authState => _auth.authStateChanges();

  // Sign in Anonymously
  Future<void> signInAnon(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message.toString(),
          ),
        ),
      );
    }
  }
}
