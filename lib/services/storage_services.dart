import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Reference documentReference(String uid) {
    return _storage.ref().child('user_profile/$uid.jpeg');
  }

  static Future<String?> uploadAndDownloadUrl(File imageFile, String uid) async{
    try{
    final storageref = documentReference(uid);
    await storageref.putFile(imageFile);

    return await storageref.getDownloadURL();
    }catch(e){
      print("Error while saving image: $e");
    }
  }
}