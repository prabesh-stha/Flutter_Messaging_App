import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/models/user.dart';

class UserServices {
 static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String collection = "users";

  static Future<void> createUser(User user) async{
    DocumentReference doc = _firestore.collection(collection).doc(user.uid);
   await doc.set({
      'uid' : user.uid,
      'name' : user.name,
      'email' : user.email,
      'photoUrl' : user.photoUrl
    });
  }

  static Future<DocumentSnapshot> getUser(String uid) async{
  return await _firestore.collection("users").doc(uid).get();
}
}

