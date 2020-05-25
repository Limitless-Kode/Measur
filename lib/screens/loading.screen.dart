import 'package:flutter/material.dart';
import 'package:measur/methods/firebaseMethods.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  FirebaseMethods firebaseMethods = FirebaseMethods();
  void reRoute() async{
    bool userFound = await firebaseMethods.foundCurrentUser();
    if(userFound)
      Navigator.pushReplacementNamed(context, "/home");
    else Navigator.pushReplacementNamed(context, "/starter");
  }

  @override
  void initState() {
    super.initState();
    reRoute();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Measur"),),
    );
  }
}