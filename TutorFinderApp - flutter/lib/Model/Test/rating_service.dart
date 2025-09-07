import 'package:cloud_firestore/cloud_firestore.dart';

class RatingService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> updateRating(String email, double? rating) async {
    try {
      var data = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (data.docs.isEmpty) throw Exception("Tutor not found");
      var doc = data.docs.first;
      var currentRating = doc.data()['rating'];
      var newRating = (currentRating + rating!) / 2;
      await _fireStore
          .collection('users')
          .doc(doc.id)
          .update({'rating': newRating});
    } catch (error) {
      print("Failed to update rating: $error");
      rethrow;
    }
  }
}
