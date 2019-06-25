import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    rpcIPAddress = _prefs.then((SharedPreferences prefs) {
      return TextEditingController(
          text: (prefs.getString('rpcip') ?? "localhost"));
    });
    authenticationKey = _prefs.then((SharedPreferences prefs) {
      return TextEditingController(text: (prefs.getString('authkey') ?? "42"));
    });
  }

  Future<TextEditingController> rpcIPAddress;
  Future<TextEditingController> authenticationKey;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        FutureBuilder<TextEditingController>(
            future: rpcIPAddress,
            builder: (BuildContext context,
                AsyncSnapshot<TextEditingController> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return TextFormField(
                        controller: snapshot.data,
                        decoration: InputDecoration(labelText: "RPC Address"));
              }
            }),
        FutureBuilder<TextEditingController>(
            future: authenticationKey,
            builder: (BuildContext context,
                AsyncSnapshot<TextEditingController> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return TextFormField(
                        controller: snapshot.data,
                        decoration:
                            InputDecoration(labelText: "Authentication Key"));
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: saveSettings,
            child: Text('Submit'),
          ),
        ),
      ],
    ));
  }

  saveSettings() async {
    final SharedPreferences prefs = await _prefs;
    final rpcIP = await rpcIPAddress;
    await prefs.setString('rpcip', rpcIP.text);
    final key = await authenticationKey;
    await prefs.setString('authkey', key.text);
  }

  Future<String> getRpcAddress() async {
    return rpcIPAddress.then((controller) => controller.text);
  }

  Future<String> getAuthKey() async {
    return authenticationKey.then((controller) => controller.text);
  }
}
