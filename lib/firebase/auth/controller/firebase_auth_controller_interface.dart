import 'package:jameswidget/firebase/firebase_response.dart';

abstract class FirebaseAuthControllerInterface{
  Future<FirebaseResponse> signIn() async => FirebaseResponse(error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: ""), result: "");
  Future<FirebaseResponse> signUp() async => FirebaseResponse(error: FirebaseResponseErrorDetail(errorCheck: FirebaseResponseError.Error, errorData: ""), result: "");
  void dispose(){}
}