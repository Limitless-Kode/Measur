import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/services/synchronization.service.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  FirebaseMethods firebaseMethods = FirebaseMethods();
  Synchronization synchronization = Synchronization();
  bool synchronizing = false;

  synchronize() async{
    bool userFound = await firebaseMethods.foundCurrentUser();
    if(userFound){
      if(await firebaseMethods.isConnected()){
        setState(() {
          synchronizing = true;
        });
        await synchronization.initialize();
      }
      Navigator.pushReplacementNamed(context, "/home");
    }
    else Navigator.pushReplacementNamed(context, "/starter");

  }

  @override
  void initState() {
    super.initState();
    synchronize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: synchronizing ? Text("Synchronizing") : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
            height: 60,
              width: 60,
              child: Image.asset("resources/images/logo.png")
            ),
            SizedBox(height: 10,),
            Text("Measur")
          ],
        ),
      ),
    );
  }
}