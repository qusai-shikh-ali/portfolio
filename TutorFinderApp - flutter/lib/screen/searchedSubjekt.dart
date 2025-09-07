import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconnations/Componet/subject_card.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/screen/subjekt_detalis.dart';
import 'package:flutter/material.dart';

class SearchedSubjekts extends StatefulWidget {
  SearchedSubjekts({super.key, required this.subject});
  String subject;
  @override
  State<SearchedSubjekts> createState() => _SearchedSubjektsState();
}

class _SearchedSubjektsState extends State<SearchedSubjekts> {
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
            StreamSubjects(fireStore: _fireStore, subject: widget.subject),
          ],
        ),
      ],
    );
  }
}

class StreamSubjects extends StatelessWidget {
  StreamSubjects(
      {super.key,
      required FirebaseFirestore fireStore,
      required String this.subject})
      : _fireStore = fireStore;
  String subject;

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore
          .collection("Subjects")
          .where('selectedGroup', isEqualTo: subject)
          .snapshots(),
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
