import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/chat.dart';
import 'package:messaging_app/models/message.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/providers/message_provider.dart';
import 'package:messaging_app/screens/message_bubble_screen.dart';
import 'package:messaging_app/services/chat_service.dart';
import 'package:messaging_app/shared/styled_text.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final User receiverUser;
  final String senderId;
  final List<String> participants;
  const ChatScreen({super.key, required this.senderId,required this.participants, required this.receiverUser});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  String? chatId;

  Future<void> _initChat() async{
    chatId = await ChatService.findChat(widget.participants);
    setState(() {
      
    });
  }

Future<void> _sendMessage() async {
  if (chatId == null || chatId!.isEmpty) {
    // Create a new chat
    Chat chat = Chat(chatId: "", participants: widget.participants);
    chatId = await ChatService.createChat(chat); // Wait for chat creation
    setState(() {}); // Update the UI to reflect the new chatId
  }

  // Now, send the message using the chatId
  if (chatId != null && chatId!.isNotEmpty) {
    Message message = Message(
      messageId: "",
      senderId: widget.senderId,
      text: _textController.text.trim(),
      sentTime: DateTime.now(),
    );
    await ChatService.sendMessage(chatId!, message);
    _textController.clear(); // Clear the text field after sending the message
  }
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle(text: widget.receiverUser.name),
      ),
      body: Column(
        children: [
          Expanded(child: chatId == null ?
            const Center(child: StyledHeading(text: "Start a new conversation."),) :

            Consumer(builder: (context, ref, child){
              final messages = chatId != null ? ref.watch(messageProvider(chatId!)) : const AsyncValue.data([]);

              return messages.when(data: (messages){
                print("Messages loaded: ${messages.length}");
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index){
                  final message = messages[index];
                  return MessageBubbleScreen(senderId: widget.senderId, message: message);
                });
              }, error: (error, _) => const StyledText(text: "Error loading message"), loading: () => const Center(child: CircularProgressIndicator(),));
            })
          ),
          Padding(padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  suffixIcon: IconButton(icon: const Icon(Icons.send_outlined, color: Colors.blueAccent,), onPressed: _sendMessage,),
                ),
              ),
              ),
              
            ],
          ),)
        ],
      ),
    );
  }
}