import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jameswidget/firebase/database/realtime/controller/firebase_realtime_database_interface.dart';
import 'package:http/http.dart' as http;
import 'package:jameswidget/firebase/firebase_response.dart';

abstract class FirebaseRealTimeDatabaseControllerInterface implements FirebaseRealTimeDatabaseInterface{
  Map<String, String> header = {'Content-Type': 'application/x-www-form-urlencoded'};
  FirebaseResponse _parse(String resBody) => FirebaseResponse(result: json.decode(resBody), error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.None, errorData: ""));
  FirebaseResponse _error(String errorData, FirebaseResponseError errorCheck) => FirebaseResponse(result: "", error: FirebaseResponseErrorDetail(errorCheck: errorCheck, errorData: errorData));
  Future<FirebaseResponse> firebaseGetReq({required String url}) async {
    http.Response _res = await http.get(Uri.parse(url), headers: this.header);
    if(_res.statusCode != 200) return this._error(_res.body, FirebaseResponseError.Error);
    return this._parse(_res.body);
  }
  Future<FirebaseResponse> firebasePostReq({required String url}) async {
    http.Response _res = await http.post(Uri.parse(url));
    if(_res.statusCode != 200) return this._error(_res.body, FirebaseResponseError.Error);
    return this._parse(_res.body);
  }
  Future<FirebaseResponse> firebasePutReq({required String url, required String data}) async {
    http.Response _res = await http.put(Uri.parse(url), headers: this.header, body: data);
    if(_res.statusCode != 200) return this._error(_res.body, FirebaseResponseError.Error);
    return this._parse(_res.body);
  }
  Future<FirebaseResponse> firebasePatchReq({required String url}) async {
    http.Response _res = await http.patch(Uri.parse(url), headers: this.header);
    if(_res.statusCode != 200) return this._error(_res.body, FirebaseResponseError.Error);
    return this._parse(_res.body);
  }
  String noneTokenEndPoint({required String docName, required String tableName}) => "https://${docName}.firebaseio.com/${tableName}.json";
  String tokenEndPoint({required String docName, required String tableName, required String authToken}) => "https://${docName}.firebaseio.com/fireblog/${tableName}.json?auth=${authToken}";
}

class FirebaseRealTimeDatabaseController extends FirebaseRealTimeDatabaseControllerInterface{

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
      if (_debugDisposed) {throw FlutterError('A $runtimeType was used after being disposed.\n''Once you have called dispose() on a $runtimeType, it can no longer be used.',);}
      return true;
    }());
    return true;
  }

  @override
  Future<FirebaseResponse> create({String token = "", required String docName, required String tableName}) {
    assert(_debugAssertNotDisposed());
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<FirebaseResponse> delete({String token = "", required String docName, required String tableName}) {
    assert(_debugAssertNotDisposed());
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<FirebaseResponse> read({
    String token = "",
    required String docName,
    required String tableName,
    Query? query
  }) async{
    assert(_debugAssertNotDisposed());
    if(token.isEmpty){
      return await this.firebaseGetReq(
        url: this.noneTokenEndPoint(docName: docName, tableName: tableName) + (query?.query() ?? "")
      );
    }
    return await this.firebaseGetReq(
      url: this.tokenEndPoint(docName: docName, tableName: tableName, authToken: token) + (query?.query() ?? "")
    );
  }

  @override
  Future<FirebaseResponse> update({String token = "", required bool isChangeValue,required String docName, required String tableName, required Map<String, dynamic> data}) async{
    assert(_debugAssertNotDisposed());
    final String _data = json.encode(data);
    if(token.isEmpty) {
      if(isChangeValue) return await this.firebasePutReq(url: this.noneTokenEndPoint(docName: docName, tableName: tableName), data: _data);
      else return await this.firebasePatchReq(url: this.noneTokenEndPoint(docName: docName, tableName: tableName));
    }
    else{
      if(isChangeValue) return await this.firebasePutReq(url: this.tokenEndPoint(docName: docName, tableName: tableName, authToken: token), data: _data);
      else return await this.firebasePatchReq(url: this.tokenEndPoint(docName: docName, tableName: tableName, authToken: token));
    }
  }
}

class Query{
  final String orderByValue;
  final String startAtValue;
  final String endAtValue;
  final int limitToLastValue;
  final int limitToFirstValue;
  final String? timeoutValue;
  Query({
    this.orderByValue = '\$key',
    this.startAtValue = "",
    this.endAtValue = "",
    this.limitToLastValue = 0,
    this.limitToFirstValue = 0,
    this.timeoutValue,
  });
  String query() {
    String _query = "?";
    if(this.orderByValue.isNotEmpty){ _query += 'orderBy=\"$orderByValue\"&'; }
    if(this.startAtValue.isNotEmpty){ _query += 'startAt=\"$startAtValue\"&'; }
    if(this.endAtValue.isNotEmpty){ _query += 'endAt=\"$endAtValue\"&';  }
    if(this.limitToLastValue != 0){ _query += "limitToLast=$limitToLastValue&"; }
    if(this.limitToFirstValue != 0){ _query += "limitToFirst=$limitToFirstValue&"; }
    if(this.timeoutValue != null){
      if(this.timeoutValue!.indexOf('min') >= 0){
        List _times = this.timeoutValue!.split('min');
        if(int.parse(_times[0].toString()) > 15){
          _query += "timeout=15min&";
        }
        else{
          _query += "timeout=$timeoutValue&";
        }
      }
      else if(this.timeoutValue!.indexOf('s') >= 0){
        List _times = this.timeoutValue!.split('s');
        if(int.parse(_times[0].toString()) > 900){
          _query += "timeout=900s&";
        }
        else{
          _query += "timeout=$timeoutValue&";
        }
      }
      else{
        _query += "timeout=$timeoutValue&";
      }
    }
    _query += "print=pretty";
    return _query;
  }
}

