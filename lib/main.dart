import 'package:contact/F_contact_func.dart';
import 'package:flutter/material.dart';
import 'Screens/contact_list.dart';
import 'Screens/call_logs_screen.dart';
import 'Screens/dial_pad.dart';
import 'Screens/frequently_contacted.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'route_1',
      routes: {
        'route_0': (context) => dialPad(),
        'route_1': (context) => contactList(),
        'route_2': (context) => searchScreen(),
        'route_3': (context) => callLogScreen(),
      },
    );
  }
}
