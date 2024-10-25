import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/message.dart';
import 'package:messaging_app/services/chat_service.dart';


final messageProvider = StreamProvider.family<List<Message>, String>((ref, chatId){
  return ChatService.getMessages(chatId);
});