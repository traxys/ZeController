import 'package:flutter/material.dart';
import 'dart:async';

class ActionPanel extends StatefulWidget {
  final Stream shouldChange;

  ActionPanel({@required this.shouldChange});

  @override
  ActionPanelState createState() => new ActionPanelState();
}

class ActionPanelState extends State<ActionPanel> {
  int count = 0;
  StreamSubscription streamSubscription;

  @override
  initState() {
    super.initState();
    streamSubscription = widget.shouldChange.listen((data) {
      incr();
    });
  }

  @override
  dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  void incr() {
    setState(() {
      count = count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(this.count.toString());
  }
}
