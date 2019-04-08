import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'dart:async';

import 'generated/server.pb.dart';
import 'generated/server.pbgrpc.dart';

void main() => runApp(ZeController());

class ZeController extends StatefulWidget {
  @override
  ZeControllerState createState() => ZeControllerState();
}

class ZeControllerState extends State<ZeController> {
  final changeNotifier = new StreamController.broadcast();
  final client = new HomeClient();

  @override
  void dispose() {
    changeNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZeController - Home Controller',
      home: DefaultTabController(
        length: modes.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text('ZeController'),
              bottom: TabBar(
                  tabs: modes.map((Mode mode) {
                return Tab(
                  text: mode.title,
                  icon: Icon(mode.icon),
                );
              }).toList()),
            ),
            body: TabBarView(children: <Widget>[
              new ActionPanel(shouldChange: changeNotifier.stream),
              new StatusViewer(),
            ]),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () => changeNotifier.sink.add(Refresh(text: "AAA")),
            )),
      ),
    );
  }
}

class Refresh {
  const Refresh({this.text});
  final String text;
}

class Mode {
  const Mode({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Mode> modes = const <Mode>[
  const Mode(title: 'ACTION', icon: Icons.settings),
  const Mode(title: 'STATUS', icon: Icons.search),
];

class ModeView extends StatelessWidget {
  const ModeView({Key key, this.mode}) : super(key: key);

  final Mode mode;
  @override
  Widget build(BuildContext context) {
    return Text(mode.title);
  }
}

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

class StatusViewer extends StatefulWidget {
  @override
  StatusViewerState createState() => new StatusViewerState();
}

class StatusViewerState extends State<StatusViewer> {
  @override
  Widget build(BuildContext context) {
    return Text('STATUS VIEWER');
  }
}

class HomeClient {
  ClientChannel channel;
  HomeManagerClient stub;

  HomeClient() {
    channel = new ClientChannel('192.168.0.10',
        port: 8080,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));

    stub = new HomeManagerClient(channel,
        options: new CallOptions(timeout: new Duration(seconds: 30)));
  }
}
