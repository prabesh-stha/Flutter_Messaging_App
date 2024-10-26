import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/chat.dart';
import 'package:messaging_app/models/chatInfo.dart';
import 'package:messaging_app/models/message.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/providers/user_provider.dart';
import 'package:messaging_app/services/chat_service.dart';
import 'package:messaging_app/services/user_services.dart';


final messageProvider = StreamProvider.family<List<Message>, String>((ref, chatId){
  return ChatService.getMessages(chatId);
});

final chatsProvider = StreamProvider<List<Chatinfo>>((ref) {
  final currentUser = ref.watch(userProvider).value;
  if (currentUser == null) return const Stream.empty();

  return ChatService.getChatLists(currentUser.uid).asyncMap((querySnapshot) async {
    List<Chatinfo> chats = [];

    for (var chatDoc in querySnapshot.docs) {
      final chat = Chat.fromFirestore(chatDoc);
      List<dynamic> participants = chatDoc['participants'];
      String otherParticipantId = participants.firstWhere((id) => id != currentUser.uid);

      // Fetch the other participant's details
      final userDoc = await UserServices.getUser(otherParticipantId);
      final receiverUser = User.fromFirestore(userDoc);

      chats.add(Chatinfo(chat: chat, receiverUser: receiverUser, senderUser: currentUser));
    }

    return chats;
  });
});
