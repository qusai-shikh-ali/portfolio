import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/admin.dart';
import 'package:firebaseconnations/screen/home_screen.dart';
import 'package:flutter/material.dart';

class IsAdmin extends StatefulWidget {
  const IsAdmin({super.key});

  @override
  State<IsAdmin> createState() => _IsAdminState();
}

class _IsAdminState extends State<IsAdmin> {
  final _model = FirebaseService();
  bool isAdmin = false;
  getRoll() async {
    var admin = await _model.isAdmin();
    setState(() {
      isAdmin = admin;
    });
    return admin;
  }

  @override
  void initState() {
    super.initState();
    getRoll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: isAdmin ? Admin() : Home());
  }
}
