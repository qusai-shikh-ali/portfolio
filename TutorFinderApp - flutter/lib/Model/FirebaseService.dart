import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final _logedUser = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;

  /*
  * Create a Subject to the _fireStore
  * @POST Function required A
  * Subjects{
  * 'tutor': Email!,
  * 'SubjectsName':,
  * 'hourlyWage':,
  * 'description':,
  * 'imgPath':,
  * } form for the Table Subjects
  * */

  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
    int age,
  ) async {
    await _fireStore.collection("users").add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
      'role': 'user',
      'bio': "",
      'phoneNumber': "",
      'profileImageUrl':
          "https://images.unsplash.com/photo-1557683316-973673baf926",
      'rating': 4.5,
      'subjects': [""]
    });
  }

  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String age,
    required String phoneNumber,
    required String profileImageUrl,
    required String biographyController,
  }) async {
    var _email = _logedUser?.email;
    var _data = await _fireStore
        .collection('users')
        .where('email', isEqualTo: _email)
        .get();
    var userID = _data.docs.first.id;
    print(userID);
    try {
      await _fireStore.collection('users').doc(userID).update({
        'first name': firstName,
        'last name': lastName,
        'email': _email,
        'bio': biographyController,
        'age': age,
        'phoneNumber': phoneNumber,
        'profileImageUrl': profileImageUrl,
      });
    } catch (error) {
      print("Failed to update user: $error");
      throw error;
    }
  }
  /*
  * Create a Subject to the _fireStore
  * @POST Function required A
  * Subjects{
  * 'tutor': Email!,
  * 'SubjectsName':,
  * 'hourlyWage':,
  * 'description':,
  * 'imgPath':,
  * } form for the Table Subjects
  * */

  Future<void> createSubject(String subjectsName, String hourlyWage,
      String description, String imgPath, String? selectedGroup) {
    String sId =
        "${_logedUser!.email.toString()}_${DateTime.now().millisecondsSinceEpoch}";

    return _fireStore.collection("Subjects").add(
      {
        'sId': sId,
        'Tutor': _logedUser.email
            .toString(), //to reduce the problems trun to a String
        'subjectsName': subjectsName,
        'hourlyWage': hourlyWage,
        'description': description,
        'imgPath': imgPath,
        'selectedGroup': selectedGroup
      },
    );
  }

  Future<void> updateSubject(String subjectsName, String hourlyWage,
      String description, String imgPath, id) {
    return _fireStore.collection("Subjects").doc(id).update(
      {
        'Tutor': _logedUser!.email
            .toString(), //to reduce the problems trun to a String
        'subjectsName': subjectsName,
        'hourlyWage': hourlyWage,
        'description': description,
        'imgPath': imgPath,
      },
    );
  }

  Future<void> deleteSubject(id) {
    return _fireStore.collection("Subjects").doc(id).delete();
  }
  // /*
  // * get all Subjects from _fireStore
  // * @return(Future<Stream<QuerySnapshot<Map<String, dynamic>>>>) a snapshots Stream/Live list
  // * */
  // getSubjects() async {
  //   var subjects = await _fireStore.collection("Subjects");
  //   return subjects;
  // }

  /*
  *
  *
  *  get a Subject by Subject id
  * @required a Subject id to find a subject
  * @return(Future<Stream<DocumentSnapshot<Map<String, dynamic>>>>) a snapshots Stream/Live list
  *  */
  Stream<QuerySnapshot<Map<String, dynamic>>>? getSubjectById(String id) {
    var subjects = _fireStore
        .collection("Subjects")
        .where('Tutor', isEqualTo: id)
        .snapshots();
    return subjects;
  }

  Future<List<Map<String, dynamic>>> getTutors() async {
    var subjects = await _fireStore
        .collection("users")
        .where('role', isEqualTo: 'Tutor')
        .get();

    List<Map<String, dynamic>> tutors = [];

    subjects.docs.forEach((element) {
      tutors.add(element.data());
    });

    return tutors;
  }

//Pending|In Progress|Completed|Rejected|On Hold|Denied
  Future<void> createRequestRoll({
    required String email,
  }) async {
    _fireStore
        .collection("TutorRequest")
        .add({'email': email, 'status': 'Pending', 'massage': ""});
  }

  Future<void> updateRequestRoll({
    required String email,
    required String status,
    required String massage,
  }) async {
    var _data = await _fireStore
        .collection('TutorRequest')
        .where('email', isEqualTo: email)
        .get();
    var userID = _data.docs.first.id;

    await _fireStore
        .collection("TutorRequest")
        .doc(userID)
        .update({'email': email, 'status': status, 'massage': massage});
  }

  Future<Object?> getRequestRoll({
    required String email,
  }) async {
    var _data = await _fireStore.collection('TutorRequest').get();

    if (_data.docs.isEmpty) {
      return false;
    } else {
      var doc = _data.docs.first;
      return TutorRequest(
        status: doc['status'],
        message: doc['massage'],
      );
    }
  }

  Future<Object?> checkRequestRoll({
    required String email,
  }) async {
    var _data = await _fireStore
        .collection('TutorRequest')
        .where('email', isEqualTo: email)
        .get();

    if (_data.docs.isEmpty) {
      return false;
    } else {
      var doc = _data.docs.first;
      return TutorRequest(
        status: doc['status'],
        message: doc['massage'],
      );
    }
  }

  Future<void> setRoll({
    required String email,
    required String roll,
  }) async {
    var _data = await _fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    var userID = _data.docs.first.id;
    // print(userID);
    try {
      await _fireStore.collection('users').doc(userID).update({
        'role': roll,
      });
    } catch (error) {
      print("Failed to update user: $error");
      throw error;
    }
  }

  Future<bool> checkRolle() async {
    var _email = _logedUser?.email;
    final _fireStore = await FirebaseFirestore.instance;
    var _data = await _fireStore
        .collection('users')
        .where('email', isEqualTo: _email)
        .get();
    var role = _data.docs.first.data()['role'];
    var check = role == 'Tutor';
    return await check;
  }

  Future<bool> isAdmin() async {
    var _email = _logedUser?.email;
    final _fireStore = await FirebaseFirestore.instance;
    var _data = await _fireStore
        .collection('users')
        .where('email', isEqualTo: _email)
        .get();
    var role = _data.docs.first.data()['role'];
    var check = role == 'admin';
    return await check;
  }

  Future<Object?> getUserData() async {
    var _email = _logedUser?.email;
    if (_email == null) {
      return null;
    }
    bool isTutor = await checkRolle();
    final _fireStore = FirebaseFirestore.instance;

    if (isTutor) {
      var _data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();
      if (_data.docs.isNotEmpty) {
        var data = _data.docs.first.data();
        return data;
      }
    } else {
      var _data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();
      if (_data.docs.isNotEmpty) {
        var data = _data.docs.first.data();
        return data;
      }
    }
    return null;
  }

  Future<Object?> getUserDatabyID(String email) async {
    var _email = email;
    if (_email == null) {
      return null;
    }
    bool isTutor = await checkRolle();
    final _fireStore = FirebaseFirestore.instance;

    if (isTutor) {
      var _data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();
      if (_data.docs.isNotEmpty) {
        var data = _data.docs.first.data();
        return data;
      }
    } else {
      var _data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();
      if (_data.docs.isNotEmpty) {
        var data = _data.docs.first.data();
        return data;
      }
    }
    return null;
  }

  Future<void> updateRating(String email, double? rat) async {
    var tutor = await _fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    var aktRat = tutor.docs.first.data()['rating'];
    var newRat = (aktRat + rat) / 2;
    var userID = tutor.docs.first.id;
    try {
      await _fireStore.collection('users').doc(userID).update({
        'rating': newRat,
      });
      // print("is update");
    } catch (error) {
      print("Failed to update user: $error");
      throw error;
    }
  }
}

class TutorRequest {
  final String status;
  final String message;

  TutorRequest({required this.status, required this.message});
}
