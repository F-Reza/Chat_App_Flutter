import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/utils/helper_function.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  const MessageItem({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: messageModel.userId == AuthService.user!.uid ?
          CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(messageModel.userName ?? messageModel.email,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),
            Text(getFormatDate(messageModel.timestamp.toDate(), 'dd/MM/yyyy HH:mm'),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(messageModel.msg,
              style: const TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.justify,),
          ],
        ),
      ),
    );
  }
}
