import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/editProfeilStud.dart';
import 'package:firebaseconnations/screen/Profile/editProfeilTutor.dart';
import 'package:flutter/material.dart';

class ProfilePrivates extends StatefulWidget {
  const ProfilePrivates({super.key});

  @override
  State<ProfilePrivates> createState() => _ProfilePrivatesState();
}

class _ProfilePrivatesState extends State<ProfilePrivates> {
  final _model = FirebaseService();
  bool _rollFuture = false;
  getRoll() async {
    var roll = await _model.checkRolle();
    setState(() {
      _rollFuture = roll;
    });
    return roll;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _rollFuture ? ProfilePrivate() : ProfilePrivateStudent());
  }
}
