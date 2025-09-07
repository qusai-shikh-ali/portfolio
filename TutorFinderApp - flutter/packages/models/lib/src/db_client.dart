import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/src/db_record.dart';

class DbClient {
  final FirebaseFirestore _firestore;

  DbClient({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> add(
      {required String collection, required Map<String, dynamic> data}) async {
    try {
      final docRef = await _firestore.collection(collection).add(data);
      return docRef.id;
    } catch (e) {
      throw Exception('Error adding a document: $e');
    }
  }

  Future<List<DbRecord>> fetchAll({
    required String collection,
  }) async {
    try {
      final colRef = _firestore.collection(
          collection); //return the refrence of the collection from which we want to retrive the data
      final documents = await colRef.get();
      return documents.docs
          .map((doc) => DbRecord(id: doc.id, data: doc.data()))
          .toList();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
