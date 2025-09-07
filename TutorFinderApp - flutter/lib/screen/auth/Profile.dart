import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/profileTutor.dart';
import 'package:firebaseconnations/screen/Profile/profile_public_student.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        body: _rollFuture ? ProfileTutor() : ProfilePublicStudent());
  }
}
