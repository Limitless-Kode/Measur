import 'package:flutter/material.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/models/Dressmaker.dart';
import 'package:measur/models/InfoMessage.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/widgets/infoTab.dart';

class RegisterPart extends StatefulWidget {
  @override
  _RegisterPartState createState() => _RegisterPartState();
}

class _RegisterPartState extends State<RegisterPart> {
  Dressmaker _dressmaker = Dressmaker();
  SQLiteMethods _sqLiteMethods = SQLiteMethods();
  bool isButtonDisabled = false;
  InfoMessage _infoMessage = InfoMessage();
  
  @override
  Widget build(BuildContext context) {
  void addUser(Dressmaker dressmaker) async{
    Response response = Response();
    setState(() { 
      isButtonDisabled = true;
      _infoMessage.waiting = true;
      _infoMessage.type = "info";
      _infoMessage.message = "Sending your details to our server";
      });

    response = await _sqLiteMethods.newDressmaker(dressmaker);

    if(!response.error){
      setState(() {
        _infoMessage.waiting = false;
        _infoMessage.message = "Redirecting...";
      });
      Navigator.pushReplacementNamed(context, "/home");
    }else{
      setState(() {
        _infoMessage.type = "error";
        _infoMessage.waiting = false;
        _infoMessage.message = response.message;
        isButtonDisabled = false;
      });
    }
  }

    double width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              InfoTab(
                width: width * 0.8, 
                type: _infoMessage.type,
                icon: Icon(Icons.info, color: Colors.white,),
                message: _infoMessage.message,
                waiting: _infoMessage.waiting,
                prefix: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 1,
                  )),
                ),
              SizedBox(height: 30),
              Container(
                width: width * 0.8,
                child: TextField(
                  onChanged: (value)=> _dressmaker.fullName = value,
                  cursorColor: Color(0xff150A42),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    labelStyle: TextStyle(fontSize: 18),
                    labelText: "Full Name",

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),

                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: width * 0.8,
                child: TextField(
                  onChanged: (value)=> _dressmaker.email = value,
                  keyboardType: TextInputType.emailAddress,
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
              SizedBox(height: 30),
              Container(
                width: width * 0.8,
                child: TextField(
                  onChanged: (value)=> _dressmaker.phone = value,
                  cursorColor: Color(0xff150A42),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),
                    prefixIcon: Icon(Icons.call),
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    labelStyle: TextStyle(fontSize: 18),
                    labelText: "Phone",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),

                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: width * 0.8,
                child: TextField(
                  onChanged: (value)=> _dressmaker.password = value,
                  obscureText: true,
                  cursorColor: Color(0xff150A42),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    labelStyle: TextStyle(fontSize: 18),
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
                    ),

                  ),
                ),
              ),
              SizedBox(height: 0),
              Container(
                  width: width * 0.8,
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: RaisedButton.icon(
                    
                    label: Text("Register",style: TextStyle(color: Colors.white),),
                    icon: Icon(Icons.person_add, color: Colors.white,),
                    onPressed: isButtonDisabled ? null : ()=> addUser(_dressmaker),
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
