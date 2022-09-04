
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

import '../pages/chatroom_page.dart';
import '../pages/user_profile.dart';

class UserItem extends StatelessWidget {
  final UserModel userModel;
  const UserItem({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, UserProfile.routeName, arguments: userModel.uid),
        title: Text(userModel.name ?? userModel.email),
        subtitle: Text(userModel.available ? 'Online' : 'Offline',
            style: TextStyle(color: userModel.available ? Colors.green : Colors.grey,),),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: userModel.image == null ? Image.asset('images/male.png',
              height: 50, width: 50, fit: BoxFit.cover):
          Image.network(userModel.image!,
              height: 50, width: 50, fit: BoxFit.cover),
        ),
        trailing:  IconButton(
            onPressed: (){
              Navigator.pushNamed(context, ChatRoomPage.routeName);
            },
            icon: Icon(Icons.chat,color: Colors.blueAccent,size: 30,)
        ),
      ),
    );
  }




}
