import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jameswidget/design_guide.dart';
import 'package:jameswidget/firebase/auth/controller/firebase_auth_email_controller.dart';
import 'package:jameswidget/firebase/firebase_response.dart';

class FirebaseEMailSignUpButton extends StatelessWidget {
  final FirebaseEMailAuthController controller;
  final imgSrc = "https://www.gstatic.com/devrel-devsite/prod/v7d29b723aef4d149fe98fb5331f45df163ead31f4cb33149234e59d978e54b1e/firebase/images/lockup.png";
  final DesignGuide designGuide;
  final Future<void> Function(FirebaseResponse) onPressed;
  const FirebaseEMailSignUpButton({
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
            image: NetworkImage(this.imgSrc)
          )
        ),
      ),
      onPressed: () async => await this.onPressed(await this.controller.signUp()),
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
              image: NetworkImage(this.imgSrc)
            )
          ),
        ),
        onPressed: () async => await this.onPressed(await this.controller.signUp()),
      ),
    );
  }
}
