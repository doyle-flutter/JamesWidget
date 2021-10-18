import 'package:flutter/material.dart';
import 'package:jameswidget_example/firebase/auth/sign_in_page.dart';
import 'package:jameswidget_example/firebase/auth/sign_up_page.dart';
import 'package:jameswidget_example/firebase/database/realtime/realtime_page.dart';

void main() => runApp(const MyApp());
const String firebaseWebApiKey = "AIzaSyB23Q1LlJxNKBSgGxmMKeBUdUdO8zQ4O1Q";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    onGenerateRoute: (RouteSettings route){
      if(route.name == FirebaseRealtimeDatabasePage.path){
        return MaterialPageRoute(
          settings: RouteSettings(name: FireBaseSignUpPage.path),
          builder: (BuildContext context) => FirebaseRealtimeDatabasePage()
        );
      }
      if(route.name == FireBaseSignInPage.path){
        return MaterialPageRoute(
          settings: RouteSettings(name: FireBaseSignInPage.path),
          builder: (BuildContext context) => FireBaseSignInPage()
        );
      }
      if(route.name == FireBaseSignUpPage.path){
        return MaterialPageRoute(
          settings: RouteSettings(name: FireBaseSignUpPage.path),
          builder: (BuildContext context) => FireBaseSignUpPage()
        );
      }
    },
    home: MainPage(),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("JamesWidget Example"),),
    body: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          FireBaseSignInPage.path,
          FireBaseSignUpPage.path,
          FirebaseRealtimeDatabasePage.path,
        ].map<Widget>(
          (String path) => TextButton(
            child: Text(path),
            onPressed: () async => await Navigator.of(context).pushNamed(path),
          )
        ).toList(),
      ),
    )
  );
}
