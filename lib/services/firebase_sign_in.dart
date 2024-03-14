// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unify/widgets/alert_Dialog.dart';
import 'package:unify/widgets/snackbar.dart';

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

      showSnackbar(context, "Account created successfully");
    } on FirebaseException catch (error) {
      Navigator.pop(context);
      showSnackbar(
        context,
        error.message.toString(),
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
      showSnackbar(
        context,
        error.message.toString(),
      );
    }
  }

  void logout(BuildContext context) {
    {
      showAlert(
        context,
        "Are you sure you want to logout?",
        "Logout?",
        "Logout",
        () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
        },
      );
    }
  }
}
