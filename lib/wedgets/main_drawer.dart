
import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/pages/launcher_page.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/chatroom_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.blue.shade700,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('images/male.png',
                      height: 100, width: 100, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10,),
                Text(AuthService.user!.email!,
                  style: const TextStyle(fontSize: 16,color: Colors.white),),
              ],
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, HomePage.routeName),
            leading: const Icon(Icons.home,size: 30,),
            title: const Text('Home'),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, ProfilePage.routeName),
            leading: const Icon(Icons.person,size: 30,),
            title: const Text('My Profile'),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, ChatRoomPage.routeName),
            leading: const Icon(Icons.chat,size: 26,),
            title: const Text('Chat Room'),
          ),
          ListTile(
            onTap: () async {
              await Provider.of<UserProvider>(context, listen: false)
                  .updateProfile(AuthService.user!.uid, {'available' : false});
              AuthService.logout().then((value) =>
              Navigator.pushReplacementNamed(context, LauncherPage.routeName));
            },
            leading: const Icon(Icons.logout,size: 30,),
            title: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
