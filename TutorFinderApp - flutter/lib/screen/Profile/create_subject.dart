import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseconnations/Componet/action_btn.dart';
import 'package:firebaseconnations/Componet/constants.dart';
import 'package:firebaseconnations/Componet/snackbar.dart';
import 'package:firebaseconnations/Componet/upload_image.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateSubject extends StatefulWidget {
  const CreateSubject({super.key});

  @override
  State<CreateSubject> createState() => _CreateSubjectState();
}

class _CreateSubjectState extends State<CreateSubject> {
  final nameController = TextEditingController();
  final hourlyController = TextEditingController();
  final textController = TextEditingController();
  final FirebaseService _subjects = FirebaseService();
  final List<String> subjectsGrup = [
    'Mathematics',
    'English',
    'Informatics',
    'Science',
    'History',
    'Geography',
    'Art',
    'Music',
    'Physical Education',
    'Religion',
  ];
  String? selectedGroup;

  final _storage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  late var destination;
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
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
      print(destination);
    } catch (e) {
      print('error occured');
    }
  }

  late String subjectsName;
  late String hourlyWage;
  late String description = "";

  @override
  Widget build(BuildContext context) {
    return AppStartMenu(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              UploadImage(() async {
                imgFromGallery();
              }, _photo),
              SizedBox(
                  height: 100,
                  child: TextField(
                      controller: nameController,
                      onChanged: (val) => {
                            setState(() {
                              subjectsName = val;
                            })
                          },
                      decoration: kTextFildDecoration.copyWith(
                          hintText: "Enter your SubjectsName",
                          icon: const Icon(Icons.subject)))),
              SizedBox(
                height: 100,
                child: DropdownButtonFormField2<String>(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Select Group',
                    style: TextStyle(fontSize: 16, color: Color(0xFF595959)),
                  ),
                  items: subjectsGrup
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF595959),
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Role.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedGroup = value;
                    });
                  },
                  onSaved: (value) {
                    selectedGroup = value;
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              SizedBox(
                  height: 100,
                  child: TextField(
                      controller: hourlyController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) => {
                            setState(() {
                              hourlyWage = val;
                            })
                          },
                      decoration: kTextFildDecoration.copyWith(
                          hintText: "Enter your hourly Wage",
                          icon: const Icon(Icons.euro)))),
              SizedBox(
                height: 100,
                child: TextField(
                  controller: textController,
                  onChanged: (val) => {
                    setState(() {
                      description = val;
                    })
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      hintText: "Subject description",
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.redAccent))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ActionBtn(() {
                  if (description == "" ||
                      hourlyWage == "" ||
                      subjectsName == "" ||
                      selectedGroup == "") {
                    showCustomSnackBar(
                        context, "Please fill in all the text fields.");
                  } else {
                    try {
                      uploadFile().then((value) => _subjects.createSubject(
                          subjectsName,
                          hourlyWage,
                          description,
                          destination,
                          selectedGroup));

                      textController.clear();
                      hourlyController.clear();
                      nameController.clear();
                      showCustomSnackBarVar(context, "updated success");
                    } catch (e) {
                      showCustomSnackBar(context, "updated error!!");
                    }
                  }
                }, "Create", Icons.arrow_right, null),
              )
            ],
          ),
        )
      ],
    );
  }
}
