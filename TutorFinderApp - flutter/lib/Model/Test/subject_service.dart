import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubjectService {
  final User? _loggedUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createSubject(
    String subjectsName,
    String hourlyWage,
    String description,
    String imgPath,
    String? selectedGroup,
  ) async {
    try {
      String? email = _loggedUser?.email;
      if (email == null) throw Exception("User not logged in");
      String sId = "${email}_${DateTime.now().millisecondsSinceEpoch}";

      await _fireStore.collection("Subjects").add({
        'sId': sId,
        'Tutor': email,
        'subjectsName': subjectsName,
        'hourlyWage': hourlyWage,
        'description': description,
        'imgPath': imgPath,
        'selectedGroup': selectedGroup
      });
    } catch (error) {
      print("Failed to create subject: $error");
      rethrow;
    }
  }

  Future<void> updateSubject(
    String subjectsName,
    String hourlyWage,
    String description,
    String imgPath,
    String id,
  ) async {
    try {
      String? email = _loggedUser?.email;
      if (email == null) throw Exception("User not logged in");
      await _fireStore.collection("Subjects").doc(id).update({
        'Tutor': email,
        'subjectsName': subjectsName,
        'hourlyWage': hourlyWage,
        'description': description,
        'imgPath': imgPath,
      });
    } catch (error) {
      print("Failed to update subject: $error");
      rethrow;
    }
  }

  Future<void> deleteSubject(String id) async {
    try {
      await _fireStore.collection("Subjects").doc(id).delete();
    } catch (error) {
      print("Failed to delete subject: $error");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSubjectById(String id) {
    return _fireStore
        .collection("Subjects")
        .where('Tutor', isEqualTo: id)
        .snapshots();
  }
}
