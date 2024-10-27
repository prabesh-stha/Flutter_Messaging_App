import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:messaging_app/models/user.dart';

class StorageServices {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Reference documentReference(String uid) {
    return _storage.ref().child('user_profile/$uid.jpeg');
  }

  static Future<String?> uploadAndDownloadUrl(
      File imageFile, String uid) async {
    try {
      final storageref = documentReference(uid);
      await storageref.putFile(imageFile);

      return await storageref.getDownloadURL();
    } catch (e) {
      print("Error while saving image: $e");
      return null;
    }
  }

  static Future<void> deleteImage(String uid) async {
    try {
      final storageref = documentReference(uid);
      await storageref.delete();
    } catch (e) {
      print("Error while deleting the image: $e");
    }
  }

  static Future<String?> upadateImage(File imageFile, User user) async {
    try {
      if (user.photoUrl == null) {
        return uploadAndDownloadUrl(imageFile, user.uid);
      } else {
        await deleteImage(user.uid);
        return uploadAndDownloadUrl(imageFile, user.uid);
      }
    } catch (e) {
      print("Error while updating image: $e");
      return null;
    }
  }
}
