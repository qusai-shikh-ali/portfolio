import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseconnations/Componet/snackbar.dart';
import 'package:firebaseconnations/Componet/subject_card.dart';
import 'package:firebaseconnations/Componet/upload_image.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/updateSubject.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePrivate extends StatefulWidget {
  const ProfilePrivate({super.key});
  @override
  State<ProfilePrivate> createState() => _ProfilePrivateState();
}

class Subject {
  final String name;

  Subject({required this.name});
}

class _ProfilePrivateState extends State<ProfilePrivate> {
  final _auth = FirebaseAuth.instance;
  final _model = FirebaseService();
  var _firstNameController = TextEditingController();
  var _biographyController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _ageController = TextEditingController();
  var _numController = TextEditingController();
  var _prisePerHourController = TextEditingController();
  var _passwd = TextEditingController();
  var _newPasswd = TextEditingController();
  var _confirmPasswd = TextEditingController();
  String? profileImageUrl;
  // to pick a image
  final _storage = FirebaseStorage.instance;
  File? _photo;
  late var destination;
  bool checkImg = false;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        checkImg = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    destination = DateTime.now().millisecond.toString();
    try {
      final ref = _storage.ref().child('images');
      final refImg = ref.child(destination);
      await refImg.putFile(_photo!);
      destination = await refImg.getDownloadURL();
      setState(() async {
        profileImageUrl = await refImg.getDownloadURL();

        print(profileImageUrl);
      });
    } catch (e) {
      print('error occured');
    }
  }

  bool _isLoading = false;
  String? _errorMessage;
  var _isObsecured;
  void toggleVisibility() {
    setState(() {
      _isObsecured = !_isObsecured;
    });
  }

  Future<void> _changePassword(String password) async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      User? user = _auth.currentUser;
      await user?.updatePassword(password);

      setState(() {
        _isLoading = false;
      });

      // Password update successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password successfully updated')),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An unknown error occurred';
      });
    }
  }

  String email = "";
  // ---------------
  void getInfos() async {
    var _infosUser = await _model.getUserData() as Map<String, dynamic>;
    setState(() {
      _firstNameController.text = _infosUser['first name'] ?? '';
      _lastNameController.text = _infosUser['last name'] ?? '';
      _ageController.text = _infosUser['age'].toString() ?? '';
      _numController.text = _infosUser['phoneNumber'] ?? '';
      _biographyController.text = _infosUser['bio'] ?? '';
      profileImageUrl = _infosUser['profileImageUrl'];
      email = _infosUser['email'];
    });
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _numController = TextEditingController();
    setState(() {
      _isObsecured = true;
      email = _auth.currentUser!.email!;
    });

    getInfos();
  }

  List<String> selectedSubjects = [];

  bool _personalInfoExpanded = false;
  bool _selectSubjectsExpanded = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _numController.dispose();
    _prisePerHourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStartMenu(
      children: [
        UploadImage(() async {
          imgFromGallery();
        }, _photo != null ? _photo : profileImageUrl),
        const SizedBox(height: 25),
        ExpansionTile(
          initiallyExpanded: _personalInfoExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _personalInfoExpanded = expanded;
            });
          },
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
                buildTextField(
                  controller: _firstNameController,
                  hintText: "First Name",
                ),
                const SizedBox(height: 10),
                buildTextField(
                  controller: _lastNameController,
                  hintText: "Last Name",
                ),
                const SizedBox(height: 10),
                buildTextField(
                  controller: _ageController,
                  hintText: "Age",
                ),
                const SizedBox(height: 10),
                buildTextField(
                  controller: _numController,
                  hintText: "Enter Your Phone Number",
                ),
                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: _biographyController,
                    onChanged: (val) => {setState(() {})},
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: "Biography description",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent))),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    try {
                      if (checkImg) {
                        uploadFile().then((value) => _model.updateUser(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            age: _ageController.text,
                            phoneNumber: _numController.text,
                            profileImageUrl: destination,
                            biographyController: _biographyController.text));
                      } else {
                        _model.updateUser(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            age: _ageController.text,
                            phoneNumber: _numController.text,
                            profileImageUrl: profileImageUrl!,
                            biographyController: _biographyController.text);
                      }
                      showCustomSnackBarVar(context, "updated success");
                    } catch (e) {
                      showCustomSnackBar(context, "updated error!!");
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        ExpansionTile(
          initiallyExpanded: _selectSubjectsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _selectSubjectsExpanded = expanded;
            });
          },
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Subjects",
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
            Container(
              child: StreamBuilder(
                stream: _model.getSubjectById(email),
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
                                builder: (context) => updateSubject(
                                      data: doc.data(),
                                      id: doc.id,
                                    ))));
                    // print(doc.data());
                    subjectsCard.add(sub);
                  });
                  return Column(
                    children: subjectsCard,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/CreateSubject");
              },
              child: const Text('Create Subject'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ExpansionTile(
          initiallyExpanded: _selectSubjectsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _selectSubjectsExpanded = expanded;
            });
          },
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Change Password",
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
            SizedBox(
              height: 20,
            ),
            buildPasswordTextField(
                controller: _newPasswd,
                hintText: "New Password",
                isObscured: _isObsecured,
                toggleVisibility: toggleVisibility),
            SizedBox(
              height: 20,
            ),
            buildPasswordTextField(
                controller: _confirmPasswd,
                hintText: "Confirm a new Password",
                isObscured: _isObsecured,
                toggleVisibility: toggleVisibility),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // TODO change password + logout
                if (_newPasswd.text == _confirmPasswd.text) {
                  _changePassword(_newPasswd.text).then((value) {
                    _auth.signOut();
                    _newPasswd.clear();
                    _confirmPasswd.clear();
                    Navigator.pushNamed(context, "/");
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password not corect')),
                  );
                }
              },
              child: const Text('Save Password'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        const SizedBox(height: 150),
        ElevatedButton(
          onPressed: () {
            _auth.signOut();
            Navigator.pushNamed(context, "/");
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  Widget buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
