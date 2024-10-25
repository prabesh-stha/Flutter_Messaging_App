import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/providers/auth_provider.dart';

final userProvider = StreamProvider.autoDispose<User?>((ref){
  final user = ref.watch(authProvider).value;

  if(user != null){
    return FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().map((doc){
      return User.fromFirestore(doc);
    });
  }else{
    return Stream.value(null);
  }
});

final usersProvider = StreamProvider.autoDispose<List<User>>((ref){
  return FirebaseFirestore.instance.collection("users").snapshots().map((snapshots){
    return snapshots.docs.map((doc){
      return User.fromFirestore(doc);
    }).toList();
    
  });
});
