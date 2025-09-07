import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconnations/screen/Profile/admin.dart';
import 'package:firebaseconnations/screen/Profile/create_subject.dart';
import 'package:firebaseconnations/screen/all_subjects.dart';
import 'package:firebaseconnations/screen/auth/Profile.dart';
import 'package:firebaseconnations/screen/auth/ProfilePrivates.dart';
import 'package:firebaseconnations/screen/auth/auth.dart';
import 'package:firebaseconnations/screen/auth/login.dart';
import 'package:firebaseconnations/screen/auth/signup_screen.dart';
import 'package:firebaseconnations/screen/home_screen.dart';
import 'package:firebaseconnations/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

final dbClient = DbClient();
void main() async {
  // Ensure Flutter bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  /*tutorRepository.createTutor();*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: const AppTheme().themeData,
      routes: {
        "/": (context) => const Auth(),
        "/Login": (context) => const Login(), //TODO change a class to auth()
        "/signupScreen": (context) => const SignUpScreen(),
        "/home": (context) => const Home(),
        "/ProfilePublic": (context) => const Profile(),
        "/ProfilePrivet": (context) => const ProfilePrivates(),
        "/CreateSubject": (context) => const CreateSubject(),
        "/AllSubjects": (context) => AllSubjects(),
        "/admin": (context) => Admin(),
      },
      title: 'Flutter Demo',
    );
  }
}
