import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/services/firebase_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/images/Vectorunify.png",
              scale: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Unify",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                context.read<FirebaseAuthMethod>().signInAnon(context);
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Text(
                    "Sign in Anonymously",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "No credentials required",
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
      ),
    ));
  }
}
