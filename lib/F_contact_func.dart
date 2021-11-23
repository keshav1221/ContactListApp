// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:call_log/call_log.dart';
// import 'package:contact/Call_log_class.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
//
// class CC extends StatefulWidget {
//   @override
//   _CCState createState() => _CCState();
// }
//
// class _CCState extends State<CC> {
//   List<Contact> contact = [];
//   List<Contact> freqcontact = [];
//   getcon() async {
//     if (await FlutterContacts.requestPermission()) {
//       // Get all contacts (fully fetched)
//       contact = await FlutterContacts.getContacts(
//           withProperties: true, withPhoto: true);
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getcon();
//   }
//
//   filterFreqContacts(List<String> Freq) {
//     List<Contact> _contacts = [];
//     // for (int i = 0; i < Freq.length; ++i) {
//     //   print(Freq[i]);
//     //   for (Contact element in contact) {
//     //     String contactName = element.displayName;
//     //
//     //     print(Freq[i]);
//     //     if (contactName.contains(Freq[i])) {
//     //       _contacts.add(element);
//     //       break;
//     //     } else {
//     //       print('1');
//     //     }
//     //   }
//     // }
//     _contacts.addAll(contact);
//     String s = Freq[0];
//     print(s);
//     _contacts.retainWhere((contact) {
//       print('1');
//       String searchTerm = 'm';
//       String contactName = contact.displayName;
//       print(contactName.contains(searchTerm) ? '1' : '0');
//       return contactName.contains(searchTerm);
//     });
//
//     setState(() {
//       contact = _contacts;
//     });
//     if (_contacts.isEmpty) print("yessss");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//             child: ListView.builder(
//           itemCount: contact.length,
//           itemBuilder: (context, index) {
//             return Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.circular(20.0),
//               child: ListTile(
//                 title: Text(contact.elementAt(index).displayName),
//                 subtitle: Text(contact.elementAt(index).id),
//                 trailing: IconButton(
//                   icon: Icon(
//                     Icons.call,
//                     color: Colors.green,
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             );
//           },
//         )),
//       ),
//     );
//   }
// }
