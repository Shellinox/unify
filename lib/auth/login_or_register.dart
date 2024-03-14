import 'package:flutter/material.dart';
import 'package:unify/Screens/login_screen.dart';
import 'package:unify/Screens/sign_up_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> { 

  bool showLoginPage = true;

    void togglePage() {
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }
  @override
  Widget build(BuildContext context) {
    

    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePage,
      );
    } else {
      return SignUpScreen(
        onTap: togglePage,
      );
    }
  }
}
