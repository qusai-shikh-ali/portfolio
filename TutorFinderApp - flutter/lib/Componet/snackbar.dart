import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  final player = AudioPlayer();
  player.play(AssetSource('note1.wav'));
}

void showCustomSnackBarVar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  final player = AudioPlayer();
  player.play(AssetSource('note1.wav'));
}

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: Colors.black12,
        width: 2,
      ),
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter somthing';
          }
          return null;
        },
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}

Widget buildPasswordTextField(
    {required TextEditingController controller,
    required String hintText,
    required bool isObscured,
    required VoidCallback toggleVisibility}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: Colors.black12,
        width: 2,
      ),
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            padding: const EdgeInsetsDirectional.only(end: 1.0),
            icon: isObscured
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: toggleVisibility,
          ),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}

List<Widget> buildColumnChildrenWithPadding(List<Widget> children) {
  return children.map((child) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: child,
    );
  }).toList();
}
