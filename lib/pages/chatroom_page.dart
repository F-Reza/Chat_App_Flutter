import 'package:chat_app/providers/chatroom_provider.dart';
import 'package:chat_app/wedgets/main_drawer.dart';
import 'package:chat_app/wedgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = 'chatroom';
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isFirst = true;
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if(isFirst) {
      Provider.of<ChatRoomProvider> (context, listen: false)
          .getChatRoomMessage();
      isFirst = false;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text('Chat Room'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Consumer<ChatRoomProvider>(
        builder: (context, provider, _) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: provider.msgList.length,
                itemBuilder: (context, index) {
                  final messageModel = provider.msgList[index];
                  return MessageItem(messageModel: messageModel);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),hintText: 'Type your message...'

                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        if(textController.text.isEmpty) return;
                        provider.addMessage(textController.text);
                        textController.clear();
                      },
                      icon: Icon(Icons.send,size: 35, color: Theme.of(context).primaryColor,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
