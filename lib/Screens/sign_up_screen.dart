import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/services/firebase_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),
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
                TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      hintText: "Confirm password",
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
                    if (passwordController.text.toString() !=
                        confirmPasswordController.text.toString()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Passwords do not match")));
                    } else {
                      Provider.of<FirebaseAuthMethod>(context, listen: false)
                          .signIn(context, emailController.text.toString(),
                              passwordController.text.toString());
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(3)),
                    child: const Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a user?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: widget.onTap,
                      child: const Text("Log in"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
