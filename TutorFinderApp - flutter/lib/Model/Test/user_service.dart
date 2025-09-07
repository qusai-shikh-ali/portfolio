import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final User? _loggedUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createUser(
      String firstName, String lastName, String email, int age) async {
    try {
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
        'rating': 0,
        'subjects': [""]
      });
    } catch (error) {
      print("Failed to create user: $error");
      rethrow;
    }
  }

  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String age,
    required String phoneNumber,
    required String profileImageUrl,
    required String biographyController,
  }) async {
    try {
      String? email = _loggedUser?.email;
      if (email == null) throw Exception("User not logged in");
      var data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      var userID = data.docs.first.id;
      await _fireStore.collection('users').doc(userID).update({
        'first name': firstName,
        'last name': lastName,
        'email': email,
        'bio': biographyController,
        'age': age,
        'phoneNumber': phoneNumber,
        'profileImageUrl': profileImageUrl,
      });
    } catch (error) {
      print("Failed to update user: $error");
      rethrow;
    }
  }

  Future<Object?> getUserData() async {
    try {
      String? email = _loggedUser?.email;
      if (email == null) throw Exception("User not logged in");
      var data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return data.docs.isNotEmpty ? data.docs.first.data() : null;
    } catch (error) {
      print("Failed to get user data: $error");
      rethrow;
    }
  }

  Future<Object?> getUserDataById(String email) async {
    try {
      var data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return data.docs.isNotEmpty ? data.docs.first.data() : null;
    } catch (error) {
      print("Failed to get user data by ID: $error");
      rethrow;
    }
  }

  Future<bool> checkRole() async {
    try {
      String? email = _loggedUser?.email;
      if (email == null) throw Exception("User not logged in");
      var data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return data.docs.first.data()['role'] == 'Tutor';
    } catch (error) {
      print("Failed to check role: $error");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTutors() async {
    try {
      var data = await _fireStore
          .collection("users")
          .where('role', isEqualTo: 'Tutor')
          .get();
      return data.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      print("Failed to get tutors: $error");
      rethrow;
    }
  }
  // TODO rolle anfordern

  // TODO rolle freigeben
}
