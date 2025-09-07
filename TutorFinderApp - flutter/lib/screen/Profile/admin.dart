import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnations/Componet/UserCard.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/ProfileTutorAdmin.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  Admin({this.subject, super.key});
  final String? subject;

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    print(widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage('images/homeK.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StreamUsers(fireStore: _fireStore),
                        ],
                      ),
                      ListTile(
                        title: ElevatedButton(
                          onPressed: () {
                            _auth.signOut();
                            Navigator.pushNamed(context, "/");
                          },
                          child: const Text('Logout'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/ChangePassword");
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StreamUsers extends StatelessWidget {
  const StreamUsers({
    super.key,
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection("TutorRequest").snapshots(),
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
        List<Widget> usersCard = [];
        final _model = FirebaseService();

        if (subjects != null) {
          for (var doc in subjects.docs) {
            final data = doc.data() as Map<String, dynamic>;
            usersCard.add(FutureBuilder(
              future: _model.getUserDatabyID(data['email']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('No data');
                }
                final userData = snapshot.data as Map<String, dynamic>;

                // Ensure the required fields are not null
                final userName =
                    "${userData['first name'] ?? 'No first name'} ${userData['last name'] ?? 'No last name'}";
                final email = userData['email'] ?? 'No email';
                final status = data['status'] ?? 'No status';
                final imgPath = userData['profileImageUrl'] ??
                    'https://images.unsplash.com/photo-1557683316-973673baf926';

                return UserCard(
                  userName,
                  email,
                  status,
                  imgPath,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileTutorAdmin(userData['email']),
                    ),
                  ),
                );
              },
            ));
          }
        }

        return Column(
          children: usersCard,
        );
      },
    );
  }
}
