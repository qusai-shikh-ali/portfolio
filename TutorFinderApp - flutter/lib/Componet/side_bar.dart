import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/ProfileTutorUS.dart';
import 'package:flutter/material.dart';

class DrawerSideBar extends StatefulWidget {
  DrawerSideBar({
    super.key,
  });

  @override
  State<DrawerSideBar> createState() => _DrawerSideBarState();
}

class _DrawerSideBarState extends State<DrawerSideBar> {
  final _model = FirebaseService();

  final _auth = FirebaseAuth.instance;

  var _userData;
  String? fname, lname, image;
  String email = "";
  getData() async {
    try {
      var test = await _model.getUserData();
      setState(() {
        _userData = test;
        email = _userData['email'];
        fname = _userData['first name'];
        lname = _userData['last name'];
        image = _userData['profileImageUrl'];
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
    return FutureBuilder<bool>(
      future: _model.checkRolle(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          if (snapshot.data!) {
            return Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileTutorUS(email)));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: image != null
                                ? NetworkImage(image!)
                                : const AssetImage("images/nour.png")
                                    as ImageProvider,
                            radius: 65.0,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Hi $fname $lname',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    // TODO: add Profile image and user name
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushNamed(context, "/");
                    },
                  ),
                  ListTile(
                    title: const Text('ProfilePublic'),
                    onTap: () {
                      Navigator.pushNamed(context, "/ProfilePublic");
                    },
                  ),
                  ListTile(
                    title: const Text('ProfilePrivet'),
                    onTap: () {
                      Navigator.pushNamed(context, "/ProfilePrivet");
                    },
                  ),
                  ListTile(
                    title: const Text('All-Subjects'),
                    onTap: () {
                      Navigator.pushNamed(context, "/AllSubjects");
                    },
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
                  ),
                ],
              ),
            );
          } else {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileTutorUS(email)));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: image != null
                                ? NetworkImage(image!)
                                : const AssetImage("images/nour.png")
                                    as ImageProvider,
                            radius: 65.0,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Hi $fname $lname',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    // TODO: add Profile image and user name
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushNamed(context, "/");
                    },
                  ),
                  ListTile(
                    title: const Text('ProfilePublic'),
                    onTap: () {
                      Navigator.pushNamed(context, "/ProfilePublic");
                    },
                  ),
                  ListTile(
                    title: const Text('ProfilePrivet'),
                    onTap: () {
                      Navigator.pushNamed(context, "/ProfilePrivet");
                    },
                  ),
                  ListTile(
                    title: const Text('All-Subjects'),
                    onTap: () {
                      Navigator.pushNamed(context, "/AllSubjects");
                    },
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
                  ),
                ],
              ),
            );
          }
        } else {
          // If the future doesn't have data (shouldn't normally happen)
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
