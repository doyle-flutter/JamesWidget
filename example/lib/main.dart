import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:jameswidget/jameswidget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Page());
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  String _platformVersion = 'Unknown';
  TextEditingController? emailController;
  TextEditingController? pwController;
  FirebaseEMailSigninController? firebaseEMailSigninController;

  @override
  void initState() {
    initPlatformState();
    firebaseEMailSigninController = FirebaseEMailSigninController(firebaseApiKey: "YourKey", email: "UserEmaile", pw: "UserPW",);
    emailController = TextEditingController()
      ..addListener(() {
        if(firebaseEMailSigninController == null || emailController == null) return;
        firebaseEMailSigninController!.email = emailController!.text;
      });
    pwController = TextEditingController()
      ..addListener(() {
        if(firebaseEMailSigninController == null || pwController == null) return;
        firebaseEMailSigninController!.pw = pwController!.text;
      });
    super.initState();
  }


  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await Jameswidget.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() => _platformVersion = platformVersion);
  }

  @override
  void dispose() {
    emailController?.dispose();
    pwController?.dispose();
    firebaseEMailSigninController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('JamesWidget Package'),),
    body: firebaseEMailSigninController == null || emailController == null || pwController == null ? Container() : SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Example(Running on: $_platformVersion)'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email"
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                controller: pwController,
                decoration: const InputDecoration(
                  hintText: "PW"
                ),
              ),
            ),
            FirebaseEMailSigninButton(
              controller: firebaseEMailSigninController!,
              onPressed: (Map<String, dynamic> result) async => print("Material : $result"),
            ),
            FirebaseEMailSigninButton(
              controller: firebaseEMailSigninController!,
              designGuide: DesignGuide.Cupertino,
              onPressed: (Map<String, dynamic> result) async => print("Cupertino : $result"),
            )
          ],
        ),
      )
    ),
  );
}

