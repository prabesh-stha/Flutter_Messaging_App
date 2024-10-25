// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:messaging_app/models/message.dart';

// class Chat {
//   String chatId;
//   List<String> participants;
//   List<Message> message;

//   Chat({required this.chatId, required this.participants, required this.message});

//   factory Chat.fromFirestore(DocumentSnapshot doc){
//     Map data = doc.data() as Map<String, dynamic>;

//     List<Message> message = (data['message'] as List<dynamic>).map((msg){
//       return Message.fromFirestore(msg);
//     }).toList();

//     return Chat(chatId: data["chatId"], participants: List<String>.from(data["participants"]), message: message);

//   }

//   Map<String, dynamic> toFirestore(){
//     return {
//       'chatId' : chatId,
//       'participants' : participants,
//       'message' : message.map((msg) => msg.toFirestore()).toList()
//     };
//   }
  
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/models/message.dart';

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