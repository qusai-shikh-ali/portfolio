import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconnations/Componet/subject_card.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/screen/subjekt_detalis.dart';
import 'package:flutter/material.dart';

class AllSubjects extends StatefulWidget {
  AllSubjects({this.subject, super.key});
  final String? subject;

  @override
  State<AllSubjects> createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {
  final _fireStore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return AppStartMenu(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamSubjects(fireStore: _fireStore),
          ],
        ),
      ],
    );
  }
}

class StreamSubjects extends StatelessWidget {
  const StreamSubjects({
    super.key,
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore.collection("Subjects").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final subjects = snapshot.data;
        List<SubjectCard> subjectsCard = [];
        subjects?.docs.forEach((doc) {
          final sub = SubjectCard(
              doc['subjectsName'],
              doc['hourlyWage'],
              doc['imgPath'],
              4,
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubjectDetails(doc.data()))));
          subjectsCard.add(sub);
        });
        return Column(
          children: subjectsCard,
        );
      },
    );
  }
}
