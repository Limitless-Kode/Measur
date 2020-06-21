import 'dart:async';
import 'package:flutter/material.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/models/User.dart';
import 'package:measur/services/synchronization.service.dart';
import 'package:measur/widgets/infoTab.dart';

class LoginPart extends StatefulWidget {
  @override
  _LoginPartState createState() => _LoginPartState();
}

class _LoginPartState extends State<LoginPart> {
  FirebaseMethods firebaseMethods = FirebaseMethods();
  Synchronization _synchronization = Synchronization();
  SQLiteMethods _sqLiteMethods = SQLiteMethods();

  User user = User();
  bool isButtonDisabled = false;
  bool waiting = true;
  String requestState;
  String message;

  clearError(){
    Timer(Duration(seconds: 3),(){
      setState(() {
        requestState = "";
        waiting = true;
      });
    });
  }

  authUser(User user) async{
    print(user.email);
    setState(() {
      isButtonDisabled = true;
      requestState = "info";
      message = "We are authenticating you.";
    });
    String uid = await firebaseMethods.signIn(email: user.email, password: user.password);

    if(uid != null){
      await _sqLiteMethods.setDressmaker();
      await _synchronization.reinitialize();

      setState(() {
        message = "Redirecting...";
      });
      Navigator.pushReplacementNamed(context, "/home");
    }else{
      clearError();
      setState(() {
        waiting = false;
        isButtonDisabled = false;
        requestState = "error";
        message = "Email and Password did not match";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              InfoTab(
                waiting: waiting,
                width: width * 0.8, 
                type: requestState, 
                icon: Icon(Icons.info, color: Colors.white,),
                message: message,
                prefix: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 1,
                  )),
                ),
              SizedBox(height: 30),
              Container(
                width: width * 0.8,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => user.email = value,
                  cursorColor: Color(0xff150A42),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),
                    prefixIcon: Icon(Icons.mail),
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    labelStyle: TextStyle(fontSize: 18),
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),
                  ),
                ),
              ),
              Container(
                width: width * 0.8,
                margin: EdgeInsets.symmetric(vertical: 30),
                child: TextField(
                  onChanged: (value) => user.password = value,
                  obscureText: true,
                  cursorColor: Color(0xff150A42),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 1, style: BorderStyle.solid)
                    ),
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    labelStyle: TextStyle(fontSize: 18,),
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
              Container(
                width: width * 0.8,
                height: 60,
                margin: EdgeInsets.only(bottom: 30),
                child: RaisedButton.icon(
                  label: Text("Login",style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.exit_to_app, color: Colors.white,),
                  onPressed: isButtonDisabled ? null :
                    () => authUser(user),
                  splashColor: Color(0xffffffff).withOpacity(0.3),
                  color: Color(0xff150A42),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
