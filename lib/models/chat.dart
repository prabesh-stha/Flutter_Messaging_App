import 'package:messaging_app/models/message.dart';

class Chat {
  String chatId;
  List<String> participants;
  List<Message> message;

  Chat({required this.chatId, required this.participants, required this.message});
  
}