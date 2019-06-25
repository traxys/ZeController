import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:async';
import 'generated/server.pb.dart';

class StatusPanel extends StatefulWidget {
  final Stream statusStream;

  StatusPanel({@required this.statusStream});

  @override
  StatusPanelState createState() => new StatusPanelState();
}

class StatusPanelState extends State<StatusPanel> {
  StreamSubscription statusStream;
  Color zeComputaColor;

  @override
  initState() {
    super.initState();
	zeComputaColor = Colors.white;
    statusStream = widget.statusStream.listen((data) {
      setState(() {
	  	if (data.runtimeType == ObjectStatus){
			var objStatus = data as ObjectStatus;
			print(objStatus.type);
			print(objStatus.id);
			if (objStatus.type == ObjectType.COMPUTER && objStatus.id == 1) {
				if (objStatus.status == Status.ON) {
					zeComputaColor = Colors.blue;
				} else if (objStatus.status == Status.OFF) {
					zeComputaColor = Colors.red;
				} else {
					zeComputaColor = Colors.grey;
				}
			}
		}
	  });
    });
  }

  @override
  dispose() {
    super.dispose();
    statusStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            Text('Ze Computa:'),
            Icon(
              Icons.power,
              color: zeComputaColor,
            )
          ])
        ]);
  }
}
