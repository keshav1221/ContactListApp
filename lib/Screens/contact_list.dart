import 'package:contact/contact_info.dart';
import 'package:flutter/material.dart';
import '../Contact_Card.dart';
import '../contact_info.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:call_log/call_log.dart';

class contactList extends StatefulWidget {
  @override
  _contactListState createState() => _contactListState();
}

class _contactListState extends State<contactList> {
  List<Contact> contacts = [];
  int _selectedIndex = 1;
  bool contactsloaded = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, 'route_$index');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getclist();
  }

  getclist() async {
    List<Contact> con = await ContactsService.getContacts();
    setState(() {
      contacts = con;
      contactsloaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, right: 20.0, left: 20.0),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contacts",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              child: contactsloaded
                  ? ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return contactCard1(
                          contacts: contacts[index],
                        );
                      },
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
                color: Colors.black54,
              ),
              title: Text(
                "Dial",
                style: TextStyle(color: Colors.black54),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts, color: Colors.black54),
              title: Text("Contacts", style: TextStyle(color: Colors.black54))),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black54),
              title: Text("Search", style: TextStyle(color: Colors.black54))),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone_callback, color: Colors.black54),
              title:
                  Text("Call logs", style: TextStyle(color: Colors.black54))),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
