import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  static const String routeName = 'create_group';
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  List<Map> availableHobbies = [
    {"name": "Reza", "isChecked": false},
    {"name": "Abid", "isChecked": false},
    {"name": "Arko", "isChecked": false,},
    {"name": "Durjoy", "isChecked": false},
    {"name": "konok", "isChecked": false},
    {"name": "Ziim", "isChecked": false},
    {"name": "Labib", "isChecked": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Group'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, CreateGroup.routeName);
              },
              icon: const Icon(Icons.add_box))
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter group name...',
                  )
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: availableHobbies.map((item) {
                  if (item["isChecked"] == true) {
                    return Card(
                      elevation: 3,
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item["name"],style: TextStyle(color: Colors.white),),
                      ),
                    );
                  }

                  return Container();
                }).toList(),
              ),
            ),
            const Divider(),
            Column(
                children: availableHobbies.map((item) {
                  return CheckboxListTile(
                      value: item["isChecked"],
                      title: Text(item["name"]),
                      onChanged: (newValue) {
                        setState(() {
                          item["isChecked"] = newValue;
                        });
                      });
                }).toList()
            ),
          ],
        ),
      ),
    );
  }
}
