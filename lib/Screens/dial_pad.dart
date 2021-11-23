import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'contact_list.dart';
import 'package:contacts_service/contacts_service.dart';

class dialPad extends StatefulWidget {
  @override
  _dialPadState createState() => _dialPadState();
}

class _dialPadState extends State<dialPad> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, 'route_$index');
    });
  }

  String display = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                display,
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dialPadButton(size, '1', Color(0xFF999999)),
                    dialPadButton(size, '2', Color(0xFF999999)),
                    dialPadButton(size, '3', Color(0xFF999999))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dialPadButton(size, '4', Color(0xFF999999)),
                    dialPadButton(size, '5', Color(0xFF999999)),
                    dialPadButton(size, '6', Color(0xFF999999))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dialPadButton(size, '7', Color(0xFF999999)),
                    dialPadButton(size, '8', Color(0xFF999999)),
                    dialPadButton(size, '9', Color(0xFF999999))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dialPadButton(size, '*', Color(0xFF999999)),
                    dialPadButton(size, '0', Color(0xFF999999)),
                    dialPadButton(size, '#', Color(0xFF999999))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          Icons.person_add_alt_1,
                          color: Colors.black54,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    await ContactsService.openContactForm();
                  },
                ),
                GestureDetector(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  onTap: () async {
                    FlutterPhoneDirectCaller.callNumber(display);
                  },
                ),
                GestureDetector(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30.0,
                      child: Center(
                        child: Icon(
                          Icons.backspace_rounded,
                          color: Colors.black54,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (display.length != 0) {
                      setState(() {
                        display = display.substring(0, display.length - 1);
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
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

  Widget dialPadButton(Size size, String value, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          display = display + value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          elevation: 5.0,
          child: Container(
            height: size.height * 0.12,
            width: size.width * 0.30,
            child: Center(
              child: Text(
                value,
                textScaleFactor: 1.0,
                style: TextStyle(
                    color: color ?? Color(0xFF5798e4),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
