// ignore_for_file: prefer_typing_uninitialized_variables

/*import 'package:dropdown_button2/dropdown_button2.dart';*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnations/Componet/snackbar.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _model = FirebaseService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final List<String> roleItems = ['Student', 'Tutor', 'Admin'];
  String? selectedRole;

  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await _model.createUser(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _emailController.text.trim(),
            int.parse(_ageController.text.trim()));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed("/");
      } catch (e) {
        showCustomSnackBar(context, "error signing Up");
      }
    }
  }

  bool passwordConfirmed() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    if (password == confirmPassword) {
      return passwordMeetsCriteria(password);
    } else {
      showCustomSnackBar(context, "The passwords didn't match");
      return false;
    }
  }

  bool passwordMeetsCriteria(String password) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&\(\)])[A-Za-z\d@\(\)$!%*?&+**,&%#*!#@]{8,}$";
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(password)) {
      return true;
    } else {
      showCustomSnackBar(context, "Your password is not strong enough");
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void openLoginScreen() {
    Navigator.pushNamed(context, '/Login');
  }

  var _isObsecured;
  void toggleVisibility() {
    setState(() {
      _isObsecured = !_isObsecured;
    });
  }

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AppStartMenu(children: [
        Text(
          'SIGN UP',
          style: GoogleFonts.robotoCondensed(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: .5,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Welcome! Here you can sign up :-)',
          style: GoogleFonts.robotoCondensed(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 25),
        buildTextField(
          controller: _firstNameController,
          hintText: "First Name",
        ),
        const SizedBox(height: 15),
        buildTextField(
          controller: _lastNameController,
          hintText: "Last Name",
        ),
        const SizedBox(height: 15),
        buildTextField(
          controller: _ageController,
          hintText: "Age",
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 15),
        buildTextField(
          controller: _emailController,
          hintText: "Email",
        ),
        const SizedBox(height: 15),
        buildPasswordTextField(
            controller: _passwordController,
            hintText: "Password",
            isObscured: _isObsecured,
            toggleVisibility: toggleVisibility),
        const SizedBox(height: 15),
        buildPasswordTextField(
            controller: _confirmPasswordController,
            hintText: "Confirm Password",
            isObscured: _isObsecured,
            toggleVisibility: toggleVisibility),
        const SizedBox(height: 25),
        GestureDetector(
          onTap: signUp,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Sign up",
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already a member? ",
              style: GoogleFonts.robotoCondensed(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            GestureDetector(
              onTap: openLoginScreen,
              child: Text(
                "Sign in here",
                style: GoogleFonts.robotoCondensed(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40)
      ]),
    );
  }
}
