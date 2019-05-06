import 'package:flutter/material.dart';
import 'dart:async';

class ActionPanel extends StatefulWidget {
  final Stream statusStream;

  ActionPanel({@required this.statusStream});

  @override
  ActionPanelState createState() => new ActionPanelState();
}

class ActionPanelState extends State<ActionPanel> {
  int count = 0;
  StreamSubscription statusStream;

  @override
  initState() {
    super.initState();
    statusStream = widget.statusStream.listen((data) {
      incr();
    });
  }

  @override
  dispose() {
    super.dispose();
    statusStream.cancel();
  }

  void incr() {
    setState(() {
      count = count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
		mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
		children: <Widget>[
            RaisedButton(
              onPressed: startComputer,
              child: Text('Start Computer'),
            ),
		]				
	);
  }

  startComputer() async {
	
  }
}
