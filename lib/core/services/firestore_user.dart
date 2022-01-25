import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/models/user_model.dart';

class FirestoreUser {
  final CollectionReference
      _userCollectionReference = FirebaseFirestore
          .instance
          .collection('users');

  Future<void> addUserToFirestore(
      UserModel userModel) async {
    return await _userCollectionReference
        .doc(userModel.id)
        .set(userModel.toJson());
  }

  Future<DocumentSnapshot> getCurrentUser(
          String uid) async =>
      await _userCollectionReference
          .doc(uid)
          .get();
}
