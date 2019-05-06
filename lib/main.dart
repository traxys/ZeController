import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'actionpanel.dart';
import 'settings.dart';

import 'generated/server.pb.dart';
import 'generated/server.pbgrpc.dart';

void main() => runApp(ZeController());

class ZeController extends StatefulWidget {
  @override
  ZeControllerState createState() => ZeControllerState();
}

class ZeControllerState extends State<ZeController> {
  final statusNotifier = new StreamController.broadcast();
  HomeClient client;
  ViewChoice _selectedChoice = viewChoices[0];
  final rpcRequestController = new StreamController();

  ZeControllerState() {
	client = new HomeClient(requestStream: rpcRequestController.stream, statusPublisher: statusNotifier.sink);
  }

  @override
  void dispose() {
    statusNotifier.close();
    super.dispose();
  }

  void _select(ViewChoice choice) {
    setState(() {
      _selectedChoice = choice;
    });
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
              actions: <Widget>[
                PopupMenuButton<ViewChoice>(
                    onSelected: _select,
                    itemBuilder: (BuildContext contex) {
                      return viewChoices.map((ViewChoice choice) {
                        return PopupMenuItem<ViewChoice>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    }),
              ],
              bottom: appBarBottom(),
            ),
            body: bodyWidget(),
            floatingActionButton: floatingButton()),
      ),
    );
  }

  bodyWidget() {
    return Container(
      child:
          SelectedView(choice: _selectedChoice, stream: statusNotifier.stream),
    );
  }

  appBarBottom() {
    if (_selectedChoice == viewChoices[0]) {
      return TabBar(
          tabs: modes.map((Mode mode) {
        return Tab(
          text: mode.title,
          icon: Icon(mode.icon),
        );
      }).toList());
    } else {
      return null;
    }
  }

  floatingButton() {
    if (_selectedChoice == viewChoices[0]) {
      return FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
		  statusNotifier.sink.add(Refresh(text: "AAA"));
          client.test();
        },
      );
    } else {
      return null;
    }
  }
}

class ViewChoice {
  ViewChoice({this.title});

  String title;
}

List<ViewChoice> viewChoices = <ViewChoice>[
  ViewChoice(title: 'Controller'),
  ViewChoice(title: 'Settings'),
];

class SelectedView extends StatelessWidget {
  final ViewChoice choice;
  final Stream stream;

  SelectedView({Key key, this.choice, this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (choice == viewChoices[0]) {
      return TabBarView(children: <Widget>[
        new ActionPanel(statusStream: stream),
        new StatusViewer(),
      ]);
    } else {
      return Center(child: new Settings());
    }
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
  StreamSubscription requests;
  StreamSink statusPublisher;

  HomeClient({@required Stream requestStream,@required this.statusPublisher}) {
    channel = new ClientChannel('192.168.1.33',
        port: 4200,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));

    stub = new HomeManagerClient(channel,
        options: new CallOptions(timeout: new Duration(seconds: 30)));
	
	requests = requestStream.listen((data) => handleRequest());
  }

  handleRequest() async {

  }

  test() async {
    final testRequest = new StatusRequest();
    final response = await stub.getStatus(testRequest);
  }
}
