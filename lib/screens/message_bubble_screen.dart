import 'package:flutter/material.dart';
import 'package:messaging_app/models/message.dart';

class MessageBubbleScreen extends StatefulWidget {
  final String senderId;
  final Message message;
  const MessageBubbleScreen({super.key, required this.senderId, required this.message});

  @override
  State<MessageBubbleScreen> createState() => _MessageBubbleScreenState();
}

class _MessageBubbleScreenState extends State<MessageBubbleScreen> {
  late bool isSender;

  @override
  void initState() {
    isSender = widget.senderId == widget.message.senderId;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender ? Colors.blueAccent: Colors.grey[300],
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(widget.message.text,
            style: TextStyle(
              color: isSender? Colors.white : Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}