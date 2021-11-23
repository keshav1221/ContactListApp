import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

class CallLogs {
  void call(String text) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  getAvator(CallType? callType) {
    switch (callType) {
      case CallType.outgoing:
        return Icon(
          Icons.call_made,
          color: Colors.green,
          size: 40.0,
        );
      case CallType.missed:
        return Icon(Icons.call_missed, color: Colors.red, size: 40.0);
      default:
        return Icon(
          Icons.call_received,
          color: Colors.blue,
          size: 40.0,
        );
    }
  }

  Future<Iterable<CallLogEntry>> getCallLogs() {
    return CallLog.get();
  }

  String formatDate(DateTime dt) {
    String s = "";
    // ('d-MMM-y H:m:s')
    s += dt.day.toString();
    s = s + '-' + dt.month.toString() + '-' + dt.year.toString() + ' ';
    s = s +
        ' ' +
        dt.hour.toString() +
        ':' +
        dt.minute.toString() +
        ':' +
        dt.second.toString();
    return s;
  }

  getTitle(CallLogEntry entry) {
    if (entry.name == null) return Text(entry.number.toString());
    if (entry.name!.isEmpty)
      return Text(entry.number.toString());
    else
      return Text(entry.name.toString());
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    if (d1.inSeconds > 0) {
      formatedDuration += d1.inSeconds.toString() + "s";
    }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }
}
