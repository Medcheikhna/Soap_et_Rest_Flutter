// import 'package:dartsoap/dartsoap.dart';

// import 'contact.dart';

// class SoapService {
//   final String wsdlUrl;
//   final String namespace;
//   final String methodName;

//   SoapService({
//     required this.wsdlUrl,
//     required this.namespace,
//     required this.methodName,
//   });

//   Future<List<Contact>> getContacts() async {
//     SoapClient client = SoapClient(wsdlUrl, namespace);
//     SoapResponse response = await client.call(methodName);

//     if (response.isSuccess) {
//       List<Contact> contacts = [];
//       response.body.forEach((soapData) {
//         contacts.add(Contact(
//           id: int.parse(soapData['Id']),
//           name: soapData['Name'],
//           email: soapData['Email'],
//           phone: soapData['Phone'],
//           url: soapData['url'],
//           photo: soapData['Photo'],
//           address: soapData['Address'],
//           notes: soapData['Notes'],
//         ));
//       });
//       return contacts;
//     } else {
//       throw Exception('Failed to load contacts');
//     }
//   }
// }
// void fetchContacts() async {
//   SoapService soapService = SoapService(
//     wsdlUrl: 'http://localhost:8089/Service_Contact?wsdl',
//     namespace: 'http://yournamespace.com',
//     methodName: 'getContacts',
//   );

//   try {
//     List<Contact> contacts = await soapService.getContacts();
//     contacts.forEach((contact) {
//       print(contact.name);
//     });
//   } catch (e) {
//     print('Error: $e');
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Soap extends StatefulWidget {
  const Soap({super.key});

  @override
  State<Soap> createState() => _SoapState();
}

class _SoapState extends State<Soap> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Soap service "),
        ),
        body: Container(
          child: Text("Hello here in service Soap"),
        ),
      ),
    );
  }
}
