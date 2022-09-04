
import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/db/db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<MessageModel> msgList = [];

  Future<void> addMessage(String msg) {
    final messageModel = MessageModel(
        msgId: DateTime.now().millisecondsSinceEpoch,
        userId: AuthService.user!.uid,
        email: AuthService.user!.email!,
        userName: AuthService.user!.displayName,
        userImage: AuthService.user!.photoURL,
        msg: msg,
        timestamp: Timestamp.now(),
    );
    return DbHelper.addMsg(messageModel);
  }

  getChatRoomMessage() {
    DbHelper.getAllChatRoomMessage().listen((snapshot) {
      msgList = List.generate(
          snapshot.docs.length, (index) =>
          MessageModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


}