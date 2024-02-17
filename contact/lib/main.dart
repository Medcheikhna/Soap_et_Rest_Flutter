import 'dart:convert';
import 'package:contact/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> contacts = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    final response = await http
        .get(Uri.parse('http://192.168.56.1:8080/server/webapi/Contacts'));

    if (response.statusCode == 200) {
      setState(() {
        contacts = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> addContact() async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8080/server/webapi/Contacts'),
      body: jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      fetchContacts();
      nameController.clear();
      emailController.clear();
      phoneController.clear();
    } else {
      throw Exception('Failed to add contact');
    }
  }

  Future<void> updateContact(
      int id, String newName, String newEmail, String newPhone) async {
    final response = await http.put(
      Uri.parse('http://192.168.56.1:8080/server/webapi/Contacts/$id'),
      body: jsonEncode({
        'name': newName,
        'email': newEmail,
        'phone': newPhone,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      fetchContacts();

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      print("Contact Update successfully");
    } else if (response.statusCode == 404) {
      throw Exception('Contact not found');
    } else {
      throw Exception('Failed to update contact');
    }
  }

  Future<void> deleteContact(int id) async {
    final response = await http.delete(
        Uri.parse('http://192.168.56.1:8080/server/webapi/Contacts/$id'));

    if (response.statusCode == 200) {
      fetchContacts();
    } else {
      throw Exception('Failed to delete contact');
    }
  }

  // void _showEditDialog(dynamic contact) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Edit Contact'),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextField(
  //                   controller: TextEditingController(text: contact['name']),
  //                   decoration: InputDecoration(hintText: 'Name'),
  //                 ),
  //                 TextField(
  //                   controller: TextEditingController(text: contact['email']),
  //                   decoration: InputDecoration(hintText: 'Email'),
  //                 ),
  //                 TextField(
  //                   controller: TextEditingController(text: contact['phone']),
  //                   decoration: InputDecoration(hintText: 'Phone'),
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               ElevatedButton(
  //                 onPressed: () {
  //                   updateContact(
  //                     contact['id'],
  //                     nameController.text,
  //                     emailController.text,
  //                     phoneController.text,
  //                   );
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Save'),
  //               ),
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: Text('Cancel'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/second': (context) => Soap(),
      // },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  // print(contact['id']);
                  return ListTile(
                    title: Text(contact['name'] ?? ''),
                    subtitle: Text(contact['phone'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Edit Contact'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: TextEditingController(
                                                text: contact['name'] ?? ''),
                                            decoration: InputDecoration(
                                                hintText: 'Name'),
                                          ),
                                          TextField(
                                            controller: TextEditingController(
                                                text: contact['email'] ?? ''),
                                            decoration: InputDecoration(
                                                hintText: 'Email'),
                                          ),
                                          TextField(
                                            controller: TextEditingController(
                                                text: contact['phone'] ?? ''),
                                            decoration: InputDecoration(
                                                hintText: 'Phone'),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            updateContact(
                                              contact['id'],
                                              nameController.text,
                                              emailController.text,
                                              phoneController.text,
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text('Save'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteContact(contact['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(hintText: 'Phone'),
                  ),
                  ElevatedButton(
                    onPressed: addContact,
                    child: Text('Add Contact'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/second');
                  //   },
                  //   child: Text('Go to page Soap Contact'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
