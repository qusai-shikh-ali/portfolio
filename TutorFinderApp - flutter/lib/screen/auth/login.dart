import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnations/Componet/snackbar.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var _isObsecured;
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } catch (e) {
      showCustomSnackBar(context, "There is no account with this password");
    }
  }

  void openSignupScreen() {
    Navigator.pushNamed(context, '/signupScreen');
  }

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final String btnText = "Sign in";
  @override
  Widget build(BuildContext context) {
    return AppStartMenu(
      children: [
        //title
        const Text(
          'SIGN IN',
          style: TextStyle(
            fontFamily: "Source Sans 3",
            color: Colors.black,
            letterSpacing: 5,
            fontSize: 55,
            fontWeight: FontWeight.bold,
          ),
        ),
        //image
        const SizedBox(height: 30),
        Image.asset(
          "images/logo.png",
          height: 250,
        ),
        //Subtitle
        Text(
          'Welcome back! Nice to see u again :-)',
          style: GoogleFonts.robotoCondensed(
            fontSize: 18,
            textStyle: const TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 25),
        //Email Textfield
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(
                color: Colors.black12, // Set the border color to black
                width: 2, // Set the border width
              ),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                ),
              ),
            ),
          ),
        ),
        //Password textfield
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(
                color: Colors.black12, // Set the border color to black
                width: 2, // Set the border width
              ),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: _isObsecured,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    padding: const EdgeInsetsDirectional.only(end: 1.0),
                    icon: _isObsecured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObsecured = !_isObsecured;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  hintText: "Password",
                ),
              ),
            ),
          ),
        ),

        //Sign in button
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: GestureDetector(
            onTap: signIn,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent[700],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  btnText,
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        //Text: Sign up
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Not yet a member? ",
              style: GoogleFonts.robotoCondensed(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            GestureDetector(
              onTap: openSignupScreen,
              child: Text(
                "Sign up now",
                style: GoogleFonts.robotoCondensed(
                    color: Colors.blue[700], fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 100)
      ],
    );
  }
}
