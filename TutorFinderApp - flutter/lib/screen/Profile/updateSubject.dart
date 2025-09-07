import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseconnations/Componet/action_btn.dart';
import 'package:firebaseconnations/Componet/constants.dart';
import 'package:firebaseconnations/Componet/upload_image.dart';
import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class updateSubject extends StatefulWidget {
  updateSubject({super.key, this.data, this.id});
  var data, id;

  @override
  State<updateSubject> createState() => _updateSubjectState();
}

class _updateSubjectState extends State<updateSubject> {
  final nameController = TextEditingController();
  final hourlyController = TextEditingController();
  final textController = TextEditingController();
  final FirebaseService _subjects = FirebaseService();

  final _storage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  var destination;
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

  // Define a function as async if you are using await inside it.

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
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.data['subjectsName'];
    hourlyController.text = widget.data['hourlyWage'];
    textController.text = widget.data['description'];
    subjectsName = widget.data['subjectsName'];
    hourlyWage = widget.data['hourlyWage'];
    description = widget.data['description'];
  }

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
              }, _photo != null ? _photo : widget.data['imgPath']),
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
                  uploadFile().then((value) => _subjects.updateSubject(
                      subjectsName,
                      hourlyWage,
                      description,
                      destination != null
                          ? destination
                          : widget.data['imgPath'],
                      widget.id));
                  Navigator.pushNamed(context, "/ProfilePublic");
                }, "Update", Icons.arrow_right, null),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ActionBtn(() {
                  _subjects.deleteSubject(widget.id);
                  Navigator.pushNamed(context, "/ProfilePublic");
                }, "delete ", Icons.arrow_right, Colors.red),
              )
            ],
          ),
        )
      ],
    );
  }
}
