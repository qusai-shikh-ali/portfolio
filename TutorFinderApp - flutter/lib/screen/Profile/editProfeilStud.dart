import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseconnations/Componet/upload_image.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/screen/Profile/applyTutorEmail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePrivateStudent extends StatefulWidget {
  const ProfilePrivateStudent({super.key});
  @override
  State<ProfilePrivateStudent> createState() => _ProfilePrivateStudentState();
}

class Subject {
  final String name;

  Subject({required this.name});
}

class _ProfilePrivateStudentState extends State<ProfilePrivateStudent> {
  final _auth = FirebaseAuth.instance;
  final _model = FirebaseService();
  late TextEditingController _firstNameController;
  late TextEditingController _biographyController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  late TextEditingController _numController;
  late TextEditingController _prisePerHourController;
  late TextEditingController _passwd;
  late TextEditingController _newPasswd;
  late TextEditingController _confirmPasswd;
  String? profileImageUrl;
  final _storage = FirebaseStorage.instance;
  File? _photo;
  String? destination;
  bool checkImg = false;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isObsecured = true;
  String email = "";
  late Widget widgetReq = Text('data');
  List<String> selectedSubjects = [];
  bool _personalInfoExpanded = false;
  bool _selectSubjectsExpanded = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _biographyController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _numController = TextEditingController();
    _prisePerHourController = TextEditingController();
    _passwd = TextEditingController();
    _newPasswd = TextEditingController();
    _confirmPasswd = TextEditingController();

    if (_auth.currentUser != null) {
      email = _auth.currentUser!.email!;
    }

    getInfos();
    checkRequst();
  }

  Future<void> imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photo = File(pickedFile.path);
        checkImg = true;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> uploadFile() async {
    if (_photo == null) return;
    try {
      final ref = _storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      await ref.putFile(_photo!);
      final url = await ref.getDownloadURL();
      setState(() {
        profileImageUrl = url;
      });
    } catch (e) {
      print('Error occurred: $e');
    }
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password successfully updated')),
      );

      _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
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

  Future<void> getInfos() async {
    var _infosUser = await _model.getUserData() as Map<String, dynamic>;
    setState(() {
      _firstNameController.text = _infosUser['first name'] ?? '';
      _lastNameController.text = _infosUser['last name'] ?? '';
      _ageController.text = _infosUser['age'].toString() ?? '';
      _numController.text = _infosUser['phoneNumber'] ?? '';
      profileImageUrl = _infosUser['profileImageUrl'];
      email = _infosUser['email'];
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.blue;
      case 'In Progress':
        return Colors.amber;
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'On Hold':
        return Colors.orange;
      case 'Denied':
        return Colors.grey;
      default:
        return Colors.black; // Default color for unknown status
    }
  }

  Future<void> checkRequst() async {
    var checkREQ = await _model.checkRequestRoll(email: email);
    setState(() {
      if (checkREQ == false) {
        widgetReq = ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApplayTutor())),
            child: const Text('Start Apply for a tutor account'));
      } else {
        var request = checkREQ as TutorRequest;

        widgetReq = Column(
          children: [
            Container(
              width: 80,
              height: 80,
              child: CircleAvatar(
                backgroundColor: getStatusColor(request.status),
                child: Text(
                  request.status,
                  style: TextStyle(
                      color: Colors
                          .white), // Set text color to white for better contrast
                ),
              ),
            ),
            Text(request.message)
          ],
        );
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _numController.dispose();
    _prisePerHourController.dispose();
    _passwd.dispose();
    _newPasswd.dispose();
    _confirmPasswd.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      _isObsecured = !_isObsecured;
    });
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
          title: const Center(
            child: Text(
              "Personal Information",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (checkImg) {
                      await uploadFile();
                    }
                    await _model.updateUser(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      age: _ageController.text,
                      phoneNumber: _numController.text,
                      profileImageUrl: profileImageUrl!,
                      biographyController: _biographyController.text,
                    );
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
          title: const Center(
            child: Text(
              "Apply for a tutor account",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          children: <Widget>[widgetReq],
        ),
        const SizedBox(height: 20),
        ExpansionTile(
          initiallyExpanded: _selectSubjectsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _selectSubjectsExpanded = expanded;
            });
          },
          title: const Center(
            child: Text(
              "Change Password",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          children: [
            const SizedBox(height: 20),
            buildPasswordTextField(
                controller: _newPasswd,
                hintText: "New Password",
                isObscured: _isObsecured,
                toggleVisibility: toggleVisibility),
            const SizedBox(height: 20),
            buildPasswordTextField(
                controller: _confirmPasswd,
                hintText: "Confirm a new Password",
                isObscured: _isObsecured,
                toggleVisibility: toggleVisibility),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_newPasswd.text == _confirmPasswd.text) {
                  await _changePassword(_newPasswd.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: const Text('Save Password'),
            ),
            const SizedBox(height: 20),
          ],
        ),
        const SizedBox(height: 20),
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

  Widget buildPasswordTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isObscured,
    required VoidCallback toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
