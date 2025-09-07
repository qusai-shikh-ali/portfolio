// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/screen/Profile/ProfileTutorUS.dart';
import 'package:flutter/material.dart';

class SubjectDetails extends StatefulWidget {
  const SubjectDetails(this.subId, {super.key});
  final subId;

  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  late var dataSub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataSub = widget.subId;
    print(widget.subId);
  }

  late String imgPath = widget.subId['imgPath'];
  @override
  Widget build(BuildContext context) {
    return AppStartMenu(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          color: Colors.white70,
          padding: const EdgeInsets.all(23),
          child: Column(
            children: [
              CircleAvatar(radius: 100, backgroundImage: NetworkImage(imgPath)),
              Text(
                widget.subId['subjectsName'],
                style:
                    const TextStyle(fontFamily: 'MontserratBold', fontSize: 24),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileTutorUS(widget.subId['Tutor'])));
                },
                child: Text(
                  "${widget.subId['Tutor']}",
                  style: const TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 24,
                      color: Colors.black26),
                ),
              ),
              const SizedBox(
                height: 20,
                width: 150,
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                      style: const TextStyle(
                          fontFamily: 'Montserratitalic',
                          fontSize: 17,
                          color: Colors.black),
                      '${widget.subId['description']}')),
            ],
          ),
        )
      ],
    );
  }
}
