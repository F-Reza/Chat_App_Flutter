
import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/pages/chatroom_page.dart';
import 'package:chat_app/pages/create_group.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/launcher_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/user_profile.dart';
import 'package:chat_app/providers/chatroom_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ChatRoomProvider()),
    ],
    child: const MyApp()));
}

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAzMaqdEoHLJ4UFw2Ss00mkfnO1F9XvWvg",
            authDomain: "agenda-cilios.firebaseapp.com",
            projectId: "agenda-cilios",
            storageBucket: "agenda-cilios.appspot.com",
            messagingSenderId: "87881805797",
            appId: "1:87881805797:web:cd3902820e5db40cda090c",
            measurementId: "G-JMXWE37BPX")
    );
  }else {
    await Firebase.initializeApp();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ChatRoomProvider()),
    ],
    child: const MyApp()));
}*/


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  // This widget is the root of your application.
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if(AuthService.user != null) {
      Provider.of<UserProvider>(context, listen: false)
          .updateProfile(AuthService.user!.uid, {'available' : true});
    }
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused) {
      if(AuthService.user != null) {
        Provider.of<UserProvider>(context, listen: false)
            .updateProfile(AuthService.user!.uid, {'available' : false});
      }
    }else if(state == AppLifecycleState.resumed) {
      if(AuthService.user != null) {
        Provider.of<UserProvider>(context, listen: false)
            .updateProfile(AuthService.user!.uid, {'available' : true});
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName : (_) => LauncherPage(),
        LoginPage.routeName : (_) => LoginPage(),
        HomePage.routeName : (_) => HomePage(),
        UserProfile.routeName : (_) => UserProfile(),
        ProfilePage.routeName : (_) => ProfilePage(),
        CreateGroup.routeName : (_) => CreateGroup(),
        ChatRoomPage.routeName : (_) => ChatRoomPage(),
      },
    );
  }
}

