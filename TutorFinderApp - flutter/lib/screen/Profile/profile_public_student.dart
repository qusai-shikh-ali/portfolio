import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:flutter/material.dart';

class ProfilePublicStudent extends StatefulWidget {
  const ProfilePublicStudent({super.key});

  @override
  State<ProfilePublicStudent> createState() => _ProfilePublicStudentState();
}

class _ProfilePublicStudentState extends State<ProfilePublicStudent> {
  final _model = FirebaseService();
  var _userData;
  String? fname, lname, image;
  String? age;

  getData() async {
    try {
      var test = await _model.getUserData();
      setState(() {
        _userData = test;
        fname = _userData['first name'];
        lname = _userData['last name'];
        age = _userData['age'];
        image = _userData['profileImageUrl'];
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return AppStartMenu(
      children: [
        CircleAvatar(
          backgroundImage: image != null
              ? NetworkImage(image!)
              : const AssetImage("images/nour.png") as ImageProvider,
          radius: 65.0,
        ),
        const SizedBox(height: 25),
        ExpansionTile(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Personal Information",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          children: [
            Column(
              children: [
                buildReadOnlyField("First Name", fname ?? "Loading..."),
                buildReadOnlyField("Last Name", lname ?? "Loading..."),
                buildReadOnlyField("Age", age?.toString() ?? "Loading..."),
              ],
            ),
          ],
        ),
        const SizedBox(height: 150),
      ],
    );
  }

  Widget buildReadOnlyField(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
