import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageId;
  String senderId;
  String text;
  DateTime sentTime;

  Message({required this.messageId, required this.senderId, required this.text, required this.sentTime});

  factory Message.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String, dynamic>;
    return Message(messageId: doc.id, senderId: data['senderId'], text: data['text'], sentTime: (data['sentTime'] as Timestamp).toDate());
  }


  Map<String, dynamic> toFirestore(){
    return {
      'messageId' : messageId,
      'senderId' : senderId,
      "text" : text,
      "sentTime" : sentTime
    };
  }
}