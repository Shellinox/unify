import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/services/firebase_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: context.watch<ThemeProvider>().isDarkMode
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white54)
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54),
                  contentPadding: const EdgeInsets.all(14),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor))),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: context.watch<ThemeProvider>().isDarkMode
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white54)
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54),
                  contentPadding: const EdgeInsets.all(14),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor))),
            ),
            const SizedBox(height: 10),
            InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                Provider.of<FirebaseAuthMethod>(context, listen: false).logIn(
                    context,
                    emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(3)),
                child: const Center(
                  child: Text(
                    "Log in",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New user?",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton(
                  onPressed: widget.onTap,
                  child: const Text("Sign in"),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
