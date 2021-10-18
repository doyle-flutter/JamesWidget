import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jameswidget/firebase/auth/controller/firebase_auth_controller_interface.dart';
import 'package:jameswidget/firebase/firebase_response.dart';

abstract class FirebaseEmailAuthController extends FirebaseAuthControllerInterface{
  Future<http.Response> connect({
    required String endPoint,
    required String apiKey,
    required String bodyData
  }) async{
    return await http.post(
      Uri.parse(endPoint+apiKey),
      headers: {'Content-Type': 'application/json'},
      body: bodyData,
    );
  }
  FirebaseResponse _parse(String resBody) => FirebaseResponse(result: json.decode(resBody), error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.None, errorData: ""));
  FirebaseResponse _error(String errorData, FirebaseResponseError errorCheck) => FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: errorCheck, errorData: errorData));
}

class FirebaseEMailAuthController extends FirebaseEmailAuthController{
  String email = "";
  String pw = "";
  String rePw = "";
  final String firebaseApiKey;
  bool _debugDisposed = false;

  FirebaseEMailAuthController({
    required this.firebaseApiKey,
    this.rePw = "",
  });

  String _bodyData(String email, String pw) => json.encode({"email":email, "password":pw, "returnSecureToken":true});

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
      if (_debugDisposed) {throw FlutterError('A $runtimeType was used after being disposed.\n''Once you have called dispose() on a $runtimeType, it can no longer be used.',);}
      return true;
    }());
    return true;
  }

  Future<FirebaseResponse> signIn() async{
    assert(_debugAssertNotDisposed());
    if(this.email.isEmpty) return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "EMail isEmpty"));
    if(this.pw.isEmpty) return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "PW isEmpty"));
    const String _endPoint = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
    try{
      final http.Response _res = await this.connect(endPoint: _endPoint, apiKey: this.firebaseApiKey, bodyData: this._bodyData(this.email, this.pw));
      if(_res.statusCode != 200) return this._error(_res.body, FirebaseResponseError.Error);
      return this._parse(_res.body);
    }
    catch(e){
      return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "ERROR"));
    }
  }

  Future<FirebaseResponse> signUp() async{
    assert(_debugAssertNotDisposed());
    if(this.email.isEmpty) return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "EMail isEmpty"));
    if(this.rePw.isEmpty) return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "RePW isEmpty"));
    if(this.pw.isEmpty) return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "PW isEmpty"));
    if(this.pw != this.rePw) return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "PW, RePW NotEqual"));
    const String _endPoint = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
    try{
      final http.Response _res = await this.connect(endPoint: _endPoint, apiKey: this.firebaseApiKey, bodyData: this._bodyData(this.email, this.pw));
      if(_res.statusCode != 200) return this._error(_res.body, FirebaseResponseError.Error);
      return this._parse(_res.body);
    }
    catch(e){
      return FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: "ERROR"));
    }
  }
}
