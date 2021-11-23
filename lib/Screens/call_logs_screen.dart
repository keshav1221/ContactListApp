import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import '../Contact_Card.dart';
import '../Call_log_class.dart';

class callLogScreen extends StatefulWidget {
  @override
  _callLogScreenState createState() => _callLogScreenState();
}

class _callLogScreenState extends State<callLogScreen> {
  late Future<Iterable<CallLogEntry>> logs;
  CallLogs cl = new CallLogs();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logs = cl.getCallLogs();
  }

  int _selectedIndex = 3;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, 'route_$index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: logs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Iterable<CallLogEntry> entries =
                  snapshot.data as Iterable<CallLogEntry>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 5.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: ListTile(
                          leading:
                              cl.getAvator(entries.elementAt(index).callType),
                          title: cl.getTitle(entries.elementAt(index)),
                          subtitle: Text(cl.formatDate(
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      entries
                                          .elementAt(index)
                                          .timestamp!
                                          .toInt())) +
                              "\n" +
                              cl.getTime(
                                  entries.elementAt(index).duration!.toInt())),
                          isThreeLine: true,
                          trailing: IconButton(
                              icon: Icon(Icons.phone),
                              color: Colors.green,
                              onPressed: () {
                                cl.call(
                                    entries.elementAt(index).number.toString());
                              }),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: entries.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
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
