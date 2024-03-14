// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unify/Screens/homepage.dart';

class FirebaseAuthMethod {
  final FirebaseAuth _auth;
  FirebaseAuthMethod(this._auth);

  // Sign in Anonymously
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (context.mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully"),
        ),
      );
    } on FirebaseException catch (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message.toString(),
          ),
        ),
      );
    }
  }

  Future<void> logIn(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseException catch (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message.toString(),
          ),
        ),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
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
