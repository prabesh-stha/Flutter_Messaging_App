import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;

  User({required this.uid, required this.name, required this.email});

  factory User.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String, dynamic>;
    return User(uid: data["uid"], name: data["name"], email: data["email"]);
  }

  Map<String, dynamic> toFirestore(){
    return{
      'uid': uid,
      'name' : name,
      "email" : email
    };
  }

}