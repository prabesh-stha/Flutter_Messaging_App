import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/services/auth_services.dart';
import 'package:messaging_app/services/storage_services.dart';

class UserServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String collection = "users";

  static Future<void> createUser(User user) async {
    DocumentReference doc = _firestore.collection(collection).doc(user.uid);
    await doc.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoUrl
    });
  }

  static Future<void> upadateImage(User user, File imageFile) async {
    final photoUrl = await StorageServices.upadateImage(imageFile, user);
    DocumentReference doc = _firestore.collection(collection).doc(user.uid);
    await doc.update({'photoUrl': photoUrl});
  }

  static Future<void> updateName(User user, String name) async {
    await _firestore
        .collection(collection)
        .doc(user.uid)
        .update({'name': name});
  }

  static Future<DocumentSnapshot> getUser(String uid) async {
    return await _firestore.collection("users").doc(uid).get();
  }

  static Future<bool> deleteUser(String uid, String password) async {
    try {
      final isauthenticated = await AuthServices.delete(password);
      if (isauthenticated) {
        await StorageServices.deleteImage(uid);
        await _firestore.collection(collection).doc(uid).delete();
        AuthServices.signOut();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error while deleting the user: $e");
      return false;
    }
  }
}
