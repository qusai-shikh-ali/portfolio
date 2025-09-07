import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnations/screen/auth/isAdmin.dart';
import 'package:firebaseconnations/screen/auth/login.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return IsAdmin();
          } else {
            return const Login();
          }
        }),
      ),
    );
  }
}
