import 'package:messaging_app/models/chat.dart';
import 'package:messaging_app/models/user.dart';

class Chatinfo {
  Chat chat;
  User receiverUser;
  User senderUser;

  Chatinfo({required this.chat, required this.receiverUser, required this.senderUser});
}