

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static const String _collectionUser = 'Users';
  static const String _collectionChatRoomMessage = 'ChatRoomMessage';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Insert User
  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(_collectionUser).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  //Get User Data
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
       _db.collection(_collectionUser).doc(uid).snapshots();


  //Update Profile
  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(_collectionUser).doc(uid).update(map);
  }


  //Message
  static Future<void> addMsg(MessageModel messageModel) =>
      _db.collection(_collectionChatRoomMessage)
      .doc().set(messageModel.toMap());

  //Get All Message
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRoomMessage() =>
      _db.collection(_collectionChatRoomMessage)
          .orderBy('msgId', descending: true).snapshots();

  //Get All Remaining Users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllRemainingUsers(String uid) =>
      _db.collection(_collectionUser)
          .where('uid', isNotEqualTo: uid).snapshots();


  static Stream<DocumentSnapshot<Map<String, dynamic>>> getContactById(String uid) =>
      _db.collection(_collectionUser).doc(uid).snapshots();




}