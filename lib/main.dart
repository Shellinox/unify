import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unify/Screens/homepage.dart';
import 'package:unify/Screens/login_screen.dart';
import 'package:unify/firebase_options.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/services/firebase_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PostProvider(),
      ),
      Provider<FirebaseAuthMethod>(
        create: (_) => FirebaseAuthMethod(FirebaseAuth.instance),
      ),
      StreamProvider(
          create: (context) => context.read<FirebaseAuthMethod>().authState,
          initialData: null)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          splashColor: Colors.transparent,
          brightness:
              themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
          primaryColor: themeProvider.isDarkMode
              ? const Color.fromRGBO(103, 66, 234, 1)
              : Colors.green,
          textTheme: TextTheme(
            titleMedium:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
            titleSmall: GoogleFonts.dmSans(fontSize: 15),
            titleLarge: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const Homepage();
    } 
      return const LoginScreen();
    
  }
}
