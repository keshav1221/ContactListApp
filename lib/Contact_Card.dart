import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class contactCard1 extends StatelessWidget {
  Contact contacts;
  void call(String text) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  contactCard1({required this.contacts});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: ListTile(
          leading: (contacts.avatar != null && contacts.avatar!.length > 0)
              ? CircleAvatar(
                  backgroundImage: MemoryImage(contacts.avatar!),
                )
              : CircleAvatar(
                  child: Text(contacts.initials(),
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.black54),
          title: Text(contacts.displayName?.toString() ?? ''),
          subtitle: Text(contacts.phones!.length == 0
              ? 'No Phone Number'
              : contacts.phones!.elementAt(0).value?.toString() ?? ''),
          trailing: IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.green,
            ),
            onPressed: () {
              call(contacts.phones!.elementAt(0).value?.toString() ?? '');
            },
          ),
        ),
      ),
    );
  }
}

class contactCard2 extends StatelessWidget {
  void call(String text) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  String name = "";
  contactCard2({required this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: ListTile(
          leading: CircleAvatar(
              child: Text(name[0], style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black54),
          title: Text(name),
          trailing: Icon(
            Icons.call,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
