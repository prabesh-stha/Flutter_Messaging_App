class Message {
  String messageId;
  String senderId;
  String text;
  DateTime sentTime;

  Message({required this.messageId, required this.senderId, required this.text, required this.sentTime});
}