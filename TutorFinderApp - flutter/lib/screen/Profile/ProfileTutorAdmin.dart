import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebaseconnations/Componet/action_btn.dart';
import 'package:firebaseconnations/Componet/snackbar.dart';
import 'package:firebaseconnations/Model/FirebaseService.dart';
import 'package:firebaseconnations/widgets/title/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfileTutorAdmin extends StatefulWidget {
  ProfileTutorAdmin(this.email);
  final String email;

  @override
  State<ProfileTutorAdmin> createState() => _ProfileTutorAdminState();
}

class _ProfileTutorAdminState extends State<ProfileTutorAdmin> {
  final List<String> status = [
    'Pending',
    'In Progress',
    'Completed',
    'Rejected',
    'On Hold',
    'Denied',
  ];
  String? selectedGroup;
  late String description = "";
  final textController = TextEditingController();
  double? rating;
  double pRating = 0.0;
  String? subjects, phoneNumber, biography, fname, lname;
  String email = "";
  final _model = FirebaseService();
  var _userData;
  String? profileImageUrl;
  bool isLoading = true;

  getData() async {
    try {
      var test = await _model.getUserDatabyID(widget.email);
      setState(() {
        _userData = test;
        fname = _userData['first name'];
        lname = _userData['last name'];
        profileImageUrl = _userData['profileImageUrl'];
        if (_userData['subjects'] is List) {
          subjects = (_userData['subjects'] as List).join(', ');
        } else {
          subjects = _userData['subjects'];
        }
        biography = _userData['bio'];
        phoneNumber = _userData['phoneNumber'];
        email = _userData['email'];
        pRating = (_userData['rating'] as num).toDouble();
        isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
                      if (isLoading)
                        Center(child: CircularProgressIndicator())
                      else
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: profileImageUrl != null
                                        ? NetworkImage(profileImageUrl!)
                                        : const AssetImage("images/nour.png")
                                            as ImageProvider,
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          "$fname $lname",
                                          style: textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.inverseSurface,
                                          ),
                                        ),
                                        Text(
                                          "$subjects",
                                          style: textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.inverseSurface,
                                          ),
                                        ),
                                        RatingBar.builder(
                                          initialRating: pRating,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          ignoreGestures: false,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.7),
                                          itemSize: 20.0,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (ratings) {
                                            _model.updateRating(email, ratings);
                                            setState(() {
                                              getData();
                                              pRating =
                                                  (_userData['rating'] as num)
                                                      .toDouble();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text('(${pRating.toStringAsFixed(1)})')
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  height: 24.0,
                                  color: colorScheme.inverseSurface,
                                ),
                                const SectionTitle(title: "Phone Number"),
                                const SizedBox(height: 15),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "$phoneNumber",
                                        style:
                                            textTheme.headlineMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.inverseSurface,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.phone,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 24.0,
                                  color: colorScheme.inverseSurface,
                                ),
                                const SectionTitle(title: "Biography"),
                                const SizedBox(height: 15),
                                Text(
                                  "$biography",
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.inverseSurface,
                                  ),
                                ),
                                Divider(
                                  height: 24.0,
                                  color: colorScheme.inverseSurface,
                                ),
                                const SectionTitle(title: "give approval"),
                                const SizedBox(height: 15),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: DropdownButtonFormField2<String>(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0))),
                                        ),
                                        isExpanded: true,
                                        hint: const Text(
                                          'Select status',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF595959)),
                                        ),
                                        items: status
                                            .map((item) =>
                                                DropdownMenuItem<String>(
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    ),
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
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.redAccent))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: ActionBtn(() {
                                        if (textController.text == "" ||
                                            selectedGroup == "") {
                                          showCustomSnackBar(context,
                                              "Please fill in all the text fields.");
                                        } else {
                                          try {
                                            // TODO update the roll
                                            _model.updateRequestRoll(
                                                email: email,
                                                status: selectedGroup as String,
                                                massage: textController.text);
                                            showCustomSnackBarVar(
                                                context, "done");
                                          } catch (e) {
                                            showCustomSnackBar(
                                                context, "updated error!!");
                                          }
                                        }
                                      }, "Send a Massege", null, Colors.red),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: ActionBtn(() {
                                        if (textController.text == "" ||
                                            selectedGroup == "") {
                                          showCustomSnackBar(context,
                                              "Please fill in all the text fields.");
                                        } else {
                                          try {
                                            // TODO update the roll
                                            _model.setRoll(
                                                email: email, roll: 'Tutor');
                                            showCustomSnackBarVar(
                                                context, "Done");
                                          } catch (e) {
                                            showCustomSnackBar(
                                                context, "updated error!!");
                                          }
                                        }
                                      }, "Accept", Icons.arrow_right,
                                          Colors.green),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: ActionBtn(() {
                                        if (textController.text == "" ||
                                            selectedGroup == "") {
                                          showCustomSnackBar(context,
                                              "Please fill in all the text fields.");
                                        } else {
                                          try {
                                            // TODO update the roll
                                            _model.setRoll(
                                                roll: 'user', email: email);
                                            showCustomSnackBarVar(
                                                context, "Done");
                                          } catch (e) {
                                            showCustomSnackBar(
                                                context, "updated error!!");
                                          }
                                        }
                                      }, "Remove the roll", null,
                                          Colors.orangeAccent),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
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
