import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:async';
import 'generated/server.pb.dart';

class ActionPanel extends StatefulWidget {
  final Stream statusStream;
  final StreamSink requestSink;

  ActionPanel({@required this.statusStream, @required this.requestSink});

  @override
  ActionPanelState createState() => new ActionPanelState();
}

class ActionPanelState extends State<ActionPanel> {
  StreamSubscription statusStream;
  StreamSink requestSink;

  @override
  initState() {
    super.initState();
    requestSink = widget.requestSink;
    statusStream = widget.statusStream.listen((data) {
      print(data);
    });
  }

  @override
  dispose() {
    super.dispose();
    statusStream.cancel();
    requestSink.close();
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
        ]);
  }

  startComputer() async {
    final computer = new Object()
      ..type = ObjectType.COMPUTER
      ..id = 1;
    requestSink.add(RPCRequest(
        request: new PowerOnRequest()..object = computer,
        type: RequestType.PowerOn));
  }
}
