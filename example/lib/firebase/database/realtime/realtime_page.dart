import 'package:flutter/material.dart';
import 'package:jameswidget/jameswidget.dart';

class FirebaseRealtimeDatabasePage extends StatefulWidget {
  const FirebaseRealtimeDatabasePage({Key? key}) : super(key: key);
  static const String path = "/firebase/database/realtime";

  @override
  State<FirebaseRealtimeDatabasePage> createState() => _FirebaseRealtimeDatabasePageState();
}

class _FirebaseRealtimeDatabasePageState extends State<FirebaseRealtimeDatabasePage> {

  FirebaseResponse? getReadData;
  FirebaseResponse? putCreateData;

  @override
  void initState() {
    Future(() async{
      this.getReadData = await this.read();
      this.putCreateData = await this.updateChange();
      if(!this.mounted) return;
      this.setState(() {});
    });
    super.initState();
  }

  Future<FirebaseResponse> read() async => await FirebaseRealTimeDatabaseController().read(
    docName: "rebase-c326f",
    tableName: "mata",
    query: Query(
      limitToFirstValue: 1,
      startAtValue: "1",
      timeoutValue: "900s",
      // orderByValue: "\$value",
    )
  );

  Future updateChange() async{
    return await FirebaseRealTimeDatabaseController().update(
      docName: "rebase-c326f",
      tableName: "users2",
      isChangeValue: true,
      data: {
        "name": "ja"
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase RealTime Database"),
      ),
      body: Container(
        child: Column(
          children: [
            Text(this.getReadData?.result.toString() ?? ""),
            Text(this.putCreateData?.result.toString() ?? "")
          ],
        ),
      ),
    );
  }
}
