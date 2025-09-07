import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/searchedSubjekt.dart';
import 'package:firebaseconnations/widgets/Avatars/subject_avatar_with_text.dart';
import 'package:firebaseconnations/widgets/list_Sub/tutors_list_sub.dart';
import 'package:firebaseconnations/widgets/title/section_title.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void openSignupScreen() {
    Navigator.pushNamed(context, '/ProfilePrivet');
  }

  final _model = FirebaseService();
  var _userData;
  String? fname, lname;
  getData() async {
    try {
      var test = await _model.getUserData();
      setState(() {
        _userData = test;
        fname = _userData['first name'];
        lname = _userData['last name'];
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 4.0),
            GestureDetector(
                onTap: openSignupScreen,
                child: Text(
                  "$fname $lname",
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 4.0),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          const SizedBox(width: 8.0),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _TutorCategories(),
            SizedBox(height: 24.0),
            _TopTutors(),
          ],
        ),
      ),
    );
  }
}

class _TutorCategories extends StatelessWidget {
  const _TutorCategories();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Title
        SectionTitle(
          title: 'Categories',
          action: 'see all',
          onPressed: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: TutorCategories.values
              .take(5)
              .map(
                (category) => Expanded(
                  child: SubjectAvatarWithTextLabel(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchedSubjekts(
                                    subject: category.name,
                                  ))),
                      icon: category.icon,
                      label: category.name),
                ),
              )
              .toList(),
        ),
        //
      ],
    );
  }
}

class _TopTutors extends StatefulWidget {
  const _TopTutors();

  @override
  State<_TopTutors> createState() => _TopTutorsState();
}

class _TopTutorsState extends State<_TopTutors> {
  List<Tutor> _tutor = [];
  final _model = FirebaseService();
  var _test;
  bool isLoading = false;
  final rnd = Random();
  getData() async {
    _test = await _model.getTutors();
    // print(_test);
  }

  @override
  void initState() {
    setState(() {
      _loadTutors();
      getData();
    });

    super.initState();
  }

  _loadTutors() async {
    //ToDo: Fetch the list of Tutors
    final tutor = await _test;
    setState(() {
      _tutor = tutor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SectionTitle(
          title: "Top Tutors",
          action: "See all",
          onPressed: () {},
        ),
        const SizedBox(
          height: 16.0,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("role", isEqualTo: 'Tutor')
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
            final Tutor = snapshot.data;
            List<TutorsListSub> TutorCard = [];
            Tutor?.docs.forEach((doc) {
              final sub = TutorsListSub(
                  doc['first name'],
                  doc['last name'],
                  doc['profileImageUrl'],
                  doc['rating'].toStringAsFixed(1),
                  doc['email']);

              TutorCard.add(sub);
            });
            return Column(
              children: TutorCard,
            );
          },
        )
      ],
    );
  }
}
