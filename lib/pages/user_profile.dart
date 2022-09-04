import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserProfile extends StatefulWidget {
  static const String routeName = 'user-profile';
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  late String userId;
  Size? size;

  @override
  void didChangeDependencies() {
    userId = ModalRoute.of(context)!.settings.arguments as String;
    print('ID->: ${userId}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, provider, _) =>
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: provider.getUserById(userId),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    final userModel = UserModel.fromMap(snapshot.data!.data()!);
                    return ListView(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: size!.width,
                              height: 280,
                              decoration: const BoxDecoration(color: Colors.white),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Text(userModel.available ? 'Online' : 'Offline',
                                style: TextStyle(color: userModel.available ? Colors.green : Colors.grey,
                                    fontSize: 18)),
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:  userModel.image == null ?
                                  Image.asset('images/male.png', height: 200, width: 200, fit: BoxFit.cover) :
                                  Image.network(userModel.image!, height: 200, width: 200, fit: BoxFit.cover),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  userModel.name == null ||  userModel.name!.isEmpty ? userModel.email : userModel.name!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      letterSpacing: 1,
                                      wordSpacing: 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Card(
                          child: ListTile(
                            title: Text(userModel.mobile == null ||  userModel.mobile!.isEmpty ?
                            'No mobile number added' : userModel.mobile!,
                              style: userModel.mobile == null ||  userModel.mobile!.isEmpty ?
                              const TextStyle(color: Colors.grey,fontSize: 14) :
                              const TextStyle(color: Colors.black, fontSize: 18),),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(onPressed: (){
                                  provider.callContact(userModel.mobile!);
                                },
                                  icon: const Icon(Icons.call,size: 30,color: Colors.greenAccent,),
                                ),
                                const SizedBox(width: 10,),
                                IconButton(onPressed: (){
                                  provider.messageContact(userModel.mobile!);
                                },
                                  icon: const Icon(Icons.sms,size: 30,color: Colors.amberAccent,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              userModel.email,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16, letterSpacing: 1),
                            ),
                            trailing: IconButton(onPressed: (){
                              if (userModel.email == null ||
                                  userModel.email.isEmpty) {
                                throw 'No email address found!';
                              } else {
                                provider.mailContact(userModel.email);
                              }
                            },
                              icon: const Icon(Icons.email,size: 30,color: Colors.redAccent,),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if(snapshot.hasError) {
                    return const Text('Failed to fatch Data');
                  }
                  return const CircularProgressIndicator();
                },
              ),
        ),
      ),
    );
  }
}
