import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'actionpanel.dart';
import 'statuspanel.dart';
import 'settings.dart';

import 'generated/server.pb.dart' as rpc_types;
import 'generated/server.pbgrpc.dart';
import 'package:protobuf/protobuf.dart' as $pb;

void main() => runApp(ZeController());

class ZeController extends StatefulWidget {
  @override
  ZeControllerState createState() => ZeControllerState();
}

class ZeControllerState extends State<ZeController> {
  final statusNotifier = new StreamController.broadcast();
  HomeClient client;
  ViewChoice _selectedChoice = viewChoices[0];
  final rpcRequestController = new StreamController<RPCRequest>();

  ZeControllerState() {
    client = new HomeClient(
        requestStream: rpcRequestController.stream,
        statusPublisher: statusNotifier.sink);
  }

  @override
  void dispose() {
    statusNotifier.close();
    rpcRequestController.close();
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
      title: 'ZeController',
      theme: new ThemeData(
        brightness: Brightness.dark, // new
      ),
      home: DefaultTabController(
        length: modes.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text('ZeController - Home Controller'),
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
      child: SelectedView(
          choice: _selectedChoice,
          stream: statusNotifier.stream,
          requestSink: rpcRequestController.sink),
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
        onPressed: () async {
          trackedDevices.forEach((tracked) async {
            var status = await client.stub
                .getStatus(rpc_types.StatusRequest()..target = tracked);
            statusNotifier.add(ObjectStatus(
                type: tracked.type, id: tracked.id, status: status.status));
          });
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

List<rpc_types.Object> trackedDevices = <rpc_types.Object>[
  rpc_types.Object()
    ..type = rpc_types.ObjectType.COMPUTER
    ..id = 1,
];

List<ViewChoice> viewChoices = <ViewChoice>[
  ViewChoice(title: 'Controller'),
  ViewChoice(title: 'Settings'),
];

class SelectedView extends StatelessWidget {
  final ViewChoice choice;
  final Stream stream;
  final Sink requestSink;

  SelectedView(
      {Key key, this.choice, @required this.stream, @required this.requestSink})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (choice == viewChoices[0]) {
      return TabBarView(children: <Widget>[
        new ActionPanel(statusStream: stream, requestSink: requestSink),
        new StatusPanel(statusStream: stream),
      ]);
    } else {
      return Center(child: new Settings());
    }
  }
}

class RefreshObject {
  const RefreshObject({this.object});
  final rpc_types.Object object;
}

class RefreshAll {}

class ObjectStatus {
  const ObjectStatus({this.type, this.id, this.status});

  final rpc_types.ObjectType type;
  final int id;
  final rpc_types.Status status;
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

enum RequestType {
  PowerOn,
}

class RPCRequest {
  final $pb.GeneratedMessage request;
  final RequestType type;

  RPCRequest({@required this.request, @required this.type});
}

class HomeClient {
  ClientChannel channel;
  HomeManagerClient stub;
  StreamSink statusPublisher;

  HomeClient({@required Stream requestStream, @required this.statusPublisher}) {
    channel = new ClientChannel('192.168.0.10',
        port: 4200,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));

    stub = new HomeManagerClient(channel,
        options: new CallOptions(timeout: new Duration(seconds: 30)));

    requestStream.forEach((request) => handleRequest(request));
  }

  handleRequest(RPCRequest request) async {
    print(request);
    if (request.type == RequestType.PowerOn) {
      final status = await stub.powerOn(request.request);
      statusPublisher.add(status);
    }
  }
}
