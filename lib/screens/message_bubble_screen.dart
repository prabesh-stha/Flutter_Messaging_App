import 'package:flutter/material.dart';
import 'package:messaging_app/models/message.dart';

class MessageBubbleScreen extends StatelessWidget {
  final bool isSender;
  final Message message;

  const MessageBubbleScreen({super.key, required this.isSender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSender ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
