import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String chatId;
  List<String> participants;


  Chat({required this.chatId, required this.participants});

  factory Chat.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String, dynamic>;

    return Chat(chatId: data["chatId"], participants: List<String>.from(data["participants"]));

  }

  Map<String, dynamic> toFirestore(){
    return {
      'chatId' : chatId,
      'participants' : participants,
    };
  }
  
}