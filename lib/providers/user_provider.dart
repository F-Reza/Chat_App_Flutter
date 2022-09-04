

import 'dart:io';

import 'package:chat_app/db/db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> remainingUserList = [];

  Future<void> addUser(UserModel userModel){
    return DbHelper.addUser(userModel);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      DbHelper.getUserById(uid);

  Future<String> updateImage(File file) async {
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('Pictures/$imageName');
    final task = photoRef.putFile(file);
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DbHelper.updateProfile(uid, map);


  getAllRemainingUsers(String uid) {
    DbHelper.getAllRemainingUsers(uid).listen((event) {
      remainingUserList = List.generate(
          event.docs.length, (index) => 
      UserModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }



  Stream<DocumentSnapshot<Map<String, dynamic>>> getContactById(String uid) =>
      DbHelper.getContactById(uid);



  //Call SMS EMAIL
  Future<void> callContact(String number) async {
    final uri = Uri.parse('tel:$number');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch call app';
    }
  }

  Future<void> messageContact(String number) async {
    final uri = Uri.parse('sms:$number');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch message app';
    }
  }

  Future<void> mailContact(String mail) async {
    final uri = Uri.parse('mailTo:$mail');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch mail app';
    }
  }



}

