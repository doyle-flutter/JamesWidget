import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jameswidget/design_guide.dart';

class FirebaseEMailSigninController{
  String email;
  String pw;
  final String firebaseApiKey;
  FirebaseEMailSigninController({
    required this.firebaseApiKey,
    required this.email,
    required this.pw
  });

  bool _debugDisposed = false;

  @mustCallSuper
  void dispose() {
    assert(_debugAssertNotDisposed());
    assert(() {
      _debugDisposed = true;
      return true;
    }());
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_debugDisposed) {
        throw FlutterError(
          'A $runtimeType was used after being disposed.\n'
              'Once you have called dispose() on a $runtimeType, it can no longer be used.',
        );
      }
      return true;
    }());
    return true;
  }

  Future<Map<String, dynamic>> signIn() async{
    assert(_debugAssertNotDisposed());
    const Map<String, String> _headers = {'Content-Type': 'application/json'};
    final String _data = json.encode({"email":this.email, "password":this.pw, "returnSecureToken":true});
    final http.Response _res = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${this.firebaseApiKey}"),
      headers: _headers,
      body: _data
    );
    if(_res.statusCode != 200) return {"err":"fail"};
    final Map<String, dynamic> _result = json.decode(_res.body);
    return _result;
  }
}

class FirebaseEMailSigninButton extends StatelessWidget {
  final FirebaseEMailSigninController controller;
  final imgSrc = "";
  final DesignGuide designGuide;
  final Future<void> Function(Map<String, dynamic>) onPressed;
  const FirebaseEMailSigninButton({
    this.designGuide = DesignGuide.Material,
    Key? key,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    if(this.designGuide == DesignGuide.Material) return MaterialButton(
      highlightColor: Colors.orangeAccent[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.orangeAccent)),
      child: Container(
        width: 60.0,
        height: 30.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://www.gstatic.com/devrel-devsite/prod/v7d29b723aef4d149fe98fb5331f45df163ead31f4cb33149234e59d978e54b1e/firebase/images/lockup.png")
          )
        ),
      ),
      onPressed: () async => await this.onPressed(await this.controller.signIn()),
    );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.activeOrange),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: CupertinoButton(
        color: CupertinoColors.white,
        minSize: 36.0,
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 0),
        child: Container(
          width: 60.0,
          height: 30.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://www.gstatic.com/devrel-devsite/prod/v7d29b723aef4d149fe98fb5331f45df163ead31f4cb33149234e59d978e54b1e/firebase/images/lockup.png")
            )
          ),
        ),
        onPressed: () async => await this.onPressed(await this.controller.signIn()),
      ),
    );
  }
}
