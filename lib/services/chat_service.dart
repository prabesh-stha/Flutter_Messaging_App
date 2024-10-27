import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/models/chat.dart';
import 'package:messaging_app/models/message.dart';

class ChatService {
static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

static Future<String?> findChat(List<String> participants) async{
  List<String> sortedParticipants = List.from(participants)..sort();
  try {
    final snapshot = await _firestore.collection("chats").where('participants', isEqualTo: sortedParticipants).get();

    if(snapshot.docs.isNotEmpty){
      return snapshot.docs.first.id;
    }else{
      return null;
    }
  }catch(e){
    return null;
  }
}

 static Future<String?> createChat(Chat chat) async{
    try{
      List<String> sortedParticipants = List.from(chat.participants)..sort();
      final DocumentReference chatReference = _firestore.collection("chats").doc();
      Chat chatToStore = Chat(chatId: chatReference.id, participants: sortedParticipants);
      chatReference.set(chatToStore.toFirestore());
      return chatToStore.chatId;
    }catch(e){
      print("Error creating chat: $e");
      return null;
    }
  }

  static Stream<QuerySnapshot> getChatLists(String userId){
      return _firestore.collection("chats").where('participants', arrayContains: userId).snapshots();
  }

 static  Future<void> sendMessage(String chatId, Message message) async{
        try{
          final DocumentReference messageReference = _firestore.collection("chats").doc(chatId).collection("message").doc();
          final Message messageToStore = Message(messageId: messageReference.id, senderId: message.senderId, text: message.text, sentTime: message.sentTime);
          await messageReference.set(messageToStore.toFirestore());
        }catch (e){
          print("Error sending message: $e");
        }
    }

  static Stream<List<Message>> getMessages(String chatId) {
  return _firestore
      .collection('chats')
      .doc(chatId)
      .collection('message')
      .orderBy('sentTime', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
      });
}

static Future<void> deleteChat(String chatId) async {
  final messagesCollection = _firestore.collection('chats').doc(chatId).collection('message');

  try {
    final messagesSnapshot = await messagesCollection.get();
    for (var doc in messagesSnapshot.docs) {
      await messagesCollection.doc(doc.id).delete();
    }
    await _firestore.collection('chats').doc(chatId).delete();
  } catch (e) {
    print("Error deleting chat: $e");
  }
}


}