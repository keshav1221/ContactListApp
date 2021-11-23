import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import '../Contact_Card.dart';
import '../Call_log_class.dart';
import '../Contact_Card.dart';
import '../contact_info.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:contact/F_contact_func.dart';

class searchScreen extends StatefulWidget {
  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  int _selectedIndex = 2;
  bool contactsLoaded = false;
  TextEditingController controller = TextEditingController();
  List<Contact> contacts = [];
  List<String> Frequently_contacted = [];
  List<Contact> searchedcontacts = [];

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
    freqcon();
    controller.addListener(() {
      filterContacts(controller.text);
    });
  }

  getclist() async {
    List<Contact> con = await ContactsService.getContacts();
    setState(() {
      contacts = con;
      contactsLoaded = true;
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    String temp = phoneStr.replaceAll('-', '');
    return temp.replaceAll(' ', '');
  } //To remove spaces and - from phone number

  bool isPresent(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    for (int i = 0; i <= len2 - len1; i++) {
      int j;

      for (j = 0; j < len1; j++) {
        if (s2[i + j] != s1[j]) break;
      }
      if (j == len1) return true;
    }
    return false;
  } // To search if a given query string s1 is present in string s2 or not

  filterContacts(String query) {
    List<Contact> _contacts = [];

    if (query.isNotEmpty) {
      _contacts = contacts.where((contact) {
        String searchTerm = query.toLowerCase();
        String searchNumberFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName!.toLowerCase();
        if (isPresent(searchTerm, contactName)) {
          return true;
        }

        if (searchNumberFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones!.firstWhereOrNull(
          (phn) {
            String phoneNumberFlattened = flattenPhoneNumber(phn.value!);
            return isPresent(searchNumberFlatten, phoneNumberFlattened);
          },
        );

        return phone != null;
      }).toList();

      setState(() {
        searchedcontacts = _contacts;
      });
    }
  } //To filter contacts according to search query

  freqcon() async {
    final Map<String, int> mp = Map();
    int i = 1;
    final Iterable<CallLogEntry> cLog = await CallLog.get();
    for (int j = 0; j < 30; ++j) {
      if (mp.containsKey(cLog.elementAt(j).name?.toString() ?? ''))
        mp.update(cLog.elementAt(j).name?.toString() ?? '', (value) => ++value);
      else
        mp[cLog.elementAt(j).name?.toString() ?? ''] = i;
    }
    var sortedMap = Map.fromEntries(
        mp.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));

    sortedMap.removeWhere((key, value) => key.isEmpty);
    List<String> con = [];
    i = 1;
    for (String key in sortedMap.keys) {
      if (i > 5) break;
      con.add(key);
      i++;
    }
    setState(() {
      Frequently_contacted = con;
    });
  } //To get Frequently contacted numbers

  @override
  Widget build(BuildContext context) {
    bool searched = controller.text.isNotEmpty;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderSide:
                    new BorderSide(color: Theme.of(context).primaryColor),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: contactsLoaded
                ? Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return searched
                            ? contactCard1(
                                contacts: searchedcontacts[index],
                              )
                            : contactCard2(name: Frequently_contacted[index]);
                      },
                      itemCount: searched
                          ? searchedcontacts.length
                          : Frequently_contacted.length,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          )
        ],
      )),
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
