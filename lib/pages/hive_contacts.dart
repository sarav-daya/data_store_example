import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
part 'hive_contacts.g.dart';

@HiveType(typeId: 1)
enum Relationship {
  @HiveField(0)
  Family,
  @HiveField(1)
  Friend,
}
const relationshipString = <Relationship, String>{
  Relationship.Family: "Family",
  Relationship.Friend: "Friend",
};

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  Relationship relationship;
  @HiveField(3)
  String phoneNumber;

  Contact(this.name, this.age, this.phoneNumber, this.relationship);
}

class HiveContactsPage extends StatefulWidget {
  HiveContactsPage({Key? key}) : super(key: key);

  @override
  State<HiveContactsPage> createState() => _HiveContactsPageState();
}

class _HiveContactsPageState extends State<HiveContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Database Example')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Contact>(contactsBoxName).listenable(),
        builder: (context, Box<Contact> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No Contacts'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Contact? currentContact = box.getAt(index);
              String? relationship =
                  relationshipString[currentContact!.relationship];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          "Do you want to delete ${currentContact.name}?",
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text("No"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () async {
                              await box.deleteAt(index);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text(currentContact.name),
                        SizedBox(height: 5),
                        Text(currentContact.phoneNumber),
                        SizedBox(height: 5),
                        Text("Age: ${currentContact.age}"),
                        SizedBox(height: 5),
                        Text("Relationship: $relationship"),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Builder(builder: ((context) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddContact()));
          },
          child: Icon(Icons.add),
        );
      })),
    );
  }
}

class AddContact extends StatefulWidget {
  AddContact({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String name = "";
  int age = 0;
  String phoneNumber = "";
  Relationship relationship = Relationship.Friend;

  void onFormSubmit() {
    Box<Contact> contactsBox = Hive.box<Contact>(contactsBoxName);
    contactsBox.add(Contact(name, age, phoneNumber, relationship));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: true,
                  initialValue: "",
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: "",
                  maxLength: 3,
                  decoration: const InputDecoration(labelText: "Age"),
                  onChanged: (value) {
                    setState(() {
                      age = int.parse(value);
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  initialValue: "",
                  decoration: const InputDecoration(
                    labelText: "Phone",
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                DropdownButton<Relationship>(
                  items: relationshipString.keys.map((Relationship value) {
                    return DropdownMenuItem<Relationship>(
                      value: value,
                      child: Text(relationshipString[value]!),
                    );
                  }).toList(),
                  value: relationship,
                  hint: Text("Relationship"),
                  onChanged: (value) {
                    setState(() {
                      relationship = value!;
                    });
                  },
                ),
                OutlinedButton(
                  child: Text("Submit"),
                  onPressed: onFormSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
