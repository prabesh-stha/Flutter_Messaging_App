import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String? photoUrl;

  User({required this.uid, required this.name, required this.email, this.photoUrl});

  factory User.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String, dynamic>;
    return User(uid: data["uid"], name: data["name"], email: data["email"], photoUrl: data["photoUrl"]);
  }

  Map<String, dynamic> toFirestore(){
    return{
      'uid': uid,
      'name' : name,
      "email" : email,
      "photUrl": photoUrl
    };
  }

}