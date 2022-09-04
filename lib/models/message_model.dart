

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  int? msgId;
  String userId;
  String? userName;
  String? userImage;
  String email;
  String msg;
  Timestamp timestamp;
  String? image;

  MessageModel(
      {this.msgId,
      required this.userId,
      this.userName,
      this.userImage,
      required this.email,
      required this.msg,
      required this.timestamp,
      this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'msgId' : msgId,
      'userId' : userId,
      'userName' : userName,
      'userImage' : userImage,
      'email' : email,
      'msg' : msg,
      'timestamp' : timestamp,
      'image' : image,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    msgId: map['msgId'],
    userId: map['userId'],
    userName: map['userName'],
    userImage: map['userImage'],
    email: map['email'],
    msg: map['msg'],
    timestamp: map['timestamp'],
    image: map['image'],
  );


}