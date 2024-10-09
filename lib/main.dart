import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/screens/app/contact_screen.dart';
import 'package:grad_project/screens/app/edit_profile_screen.dart';
import 'package:grad_project/screens/app/home_screen.dart';
import 'package:grad_project/screens/app/profile_screen.dart';
import 'package:grad_project/screens/app/references_screen.dart';
import 'package:grad_project/screens/auth/forget_password_screen.dart';
import 'package:grad_project/screens/auth/guard_screen.dart';
import 'package:grad_project/screens/auth/login_screen.dart';
import 'package:grad_project/screens/auth/register_screen.dart';
import 'package:grad_project/screens/auth/splash_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/register_screen': (context) => const RegisterScreen(),
        '/login_screen': (context) => LoginScreen(isUser: true),
        '/splash_screen': (context) => const SplashScreen(),
        '/forget_password_screen': (context) => const ForgetPasswordScreen(),
        '/references_screen': (context) => const ReferencesScreen(),
        '/profile_screen': (context) => ProfileScreen(),
        '/edit_profile_screen': (context) => EditProfileScreen(),
        '/contact_screen': (context) => const ContactScreen(),
        '/guard_screen': (context) => const GuardScreen(),
        // '/home_screen': (context) => HomeScreen(user: null, isDoctor: false,),
      },
      initialRoute: '/splash_screen',
    );
  }
}
