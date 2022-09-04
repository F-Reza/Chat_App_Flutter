import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/wedgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../wedgets/main_drawer.dart';
import 'create_group.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFirst = true;
  TextEditingController searchCtrl = TextEditingController();
  String searchVal = '';

  @override
  void didChangeDependencies() {
    if(isFirst) {
      Provider.of<UserProvider>(context, listen: false)
          .getAllRemainingUsers(AuthService.user!.uid);
    }
    super.didChangeDependencies();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, CreateGroup.routeName);
              },
              icon: const Icon(Icons.group_add))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchCtrl,
              onChanged: (val){
                setState(() {
                  searchVal = val;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search with name..',
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.remainingUserList.length,
          itemBuilder: (context, index) {
            final user = provider.remainingUserList[index];
            String tempName = user.name.toString();
            if (searchVal.isEmpty){
              return UserItem(userModel: user);
            }
            else if(tempName.toLowerCase().contains(searchCtrl.text.toString().toLowerCase())){
              return UserItem(userModel: user);
            }
            return Container();
          },
        ),
      ),
    );
  }




}
