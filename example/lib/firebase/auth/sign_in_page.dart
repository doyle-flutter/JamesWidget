import 'package:flutter/material.dart';
import 'package:jameswidget/jameswidget.dart';
import 'package:jameswidget_example/main.dart';

class FireBaseSignInPage extends StatefulWidget {
  const FireBaseSignInPage({Key? key}) : super(key: key);
  static const path = '/firebase/signin';

  @override
  State<FireBaseSignInPage> createState() => _FireBaseSignInPageState();
}

class _FireBaseSignInPageState extends State<FireBaseSignInPage> {
  TextEditingController? emailController;
  TextEditingController? pwController;

  FirebaseEMailAuthController? firebaseEMailSigninController;

  @override
  void initState() {
    firebaseEMailSigninController = FirebaseEMailAuthController(
      firebaseApiKey: firebaseWebApiKey
    );
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

  @override
  void dispose() {
    emailController?.dispose();
    pwController?.dispose();
    firebaseEMailSigninController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('JamesWidget Firebase SignIN'),),
    body: firebaseEMailSigninController == null || emailController == null || pwController == null ? Container() : SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage("https://raw.githubusercontent.com/doyle-flutter/Recipe/master/2019-11-21.webp")
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email"
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: TextField(
                  obscureText: true,
                  controller: pwController,
                  decoration: const InputDecoration(
                    hintText: "PW"
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FirebaseEMailSignInButton(
                      designGuide: DesignGuide.Material,
                      controller: firebaseEMailSigninController!,
                      onPressed: (FirebaseResponse res) async
                        => print("Material : ${res.result} / ${res.error.errorData}"),
                    ),
                    FirebaseEMailSignInButton(
                      designGuide: DesignGuide.Cupertino,
                      controller: firebaseEMailSigninController!,
                      onPressed: (FirebaseResponse res) async
                        => print("Cupertino : ${res.result} / ${res.error.errorData}"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ),
  );
}