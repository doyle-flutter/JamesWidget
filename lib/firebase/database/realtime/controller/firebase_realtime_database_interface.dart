import 'package:jameswidget/firebase/firebase_response.dart';

abstract class FirebaseRealTimeDatabaseInterface{
  Future<FirebaseResponse> read({String token = "", required String docName, required String tableName}) async => FirebaseResponse(error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: ""), result: "");
  Future<FirebaseResponse> create({String token = "", required String docName, required String tableName}) async => FirebaseResponse(error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: ""), result: "");
  Future<FirebaseResponse> update({String token = "", required String docName, required String tableName, required bool isChangeValue, required Map<String, dynamic> data}) async => FirebaseResponse(error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: ""), result: "");
  Future<FirebaseResponse> delete({String token = "", required String docName, required String tableName}) async => FirebaseResponse(error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: ""), result: "");
}

