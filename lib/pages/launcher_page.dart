
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/firebase_auth.dart';
import 'home_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = 'launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero,() {
      if(AuthService.user==null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }else {
        Navigator.pushReplacementNamed(context, HomePage.routeName);

        print('Login Successfully!');
        Fluttertoast.showToast(
          msg: 'Login Successfully!',
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,);
    }
  });
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
