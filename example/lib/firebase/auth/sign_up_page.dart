import 'package:flutter/material.dart';
import 'package:jameswidget/firebase/auth/widget/signup_btn.dart';
import 'package:jameswidget/jameswidget.dart';
import 'package:jameswidget_example/main.dart';

class FireBaseSignUpPage extends StatefulWidget {
  const FireBaseSignUpPage({Key? key}) : super(key: key);
  static const path = '/firebase/signup';

  @override
  State<FireBaseSignUpPage> createState() => _FireBaseSignUpPageState();
}

class _FireBaseSignUpPageState extends State<FireBaseSignUpPage> {
  TextEditingController? emailController;
  TextEditingController? pwController;
  TextEditingController? rePwController;
  FirebaseEMailAuthController? firebaseEMailSigninController;

  @override
  void initState() {
    firebaseEMailSigninController = FirebaseEMailAuthController(
      firebaseApiKey: firebaseWebApiKey
    );
    emailController = TextEditingController()
      ..addListener(() {
        if(firebaseEMailSigninController == null || pwController == null || rePwController == null) return;
        firebaseEMailSigninController!.email = emailController!.text;
      });
    pwController = TextEditingController()
      ..addListener(() {
        if(firebaseEMailSigninController == null || pwController == null || rePwController == null) return;
        firebaseEMailSigninController!.pw = pwController!.text;
      });
    rePwController = TextEditingController()
      ..addListener(() {
        if(firebaseEMailSigninController == null || pwController == null || rePwController == null) return;
        firebaseEMailSigninController!.rePw = rePwController!.text;
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
    appBar: AppBar(title: const Text('JamesWidget Firebase SignUP'),),
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
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: TextField(
                  obscureText: true,
                  controller: rePwController,
                  decoration: const InputDecoration(
                    hintText: "rePW"
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FirebaseEMailSignUpButton(
                      designGuide: DesignGuide.Material,
                      controller: firebaseEMailSigninController!,
                      onPressed: (FirebaseResponse result) async => print("Material : ${result.result} / ${result.error.errorData}"),
                    ),
                    FirebaseEMailSignUpButton(
                      designGuide: DesignGuide.Cupertino,
                      controller: firebaseEMailSigninController!,
                      onPressed: (FirebaseResponse result) async => print("Cupertino : ${result.result} / ${result.error.errorData}"),
                    )
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