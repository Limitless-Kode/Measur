import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measur/pageParts/login.part.dart';
import 'package:measur/pageParts/register.part.dart';
import 'package:measur/widgets/infoTab.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PageController _pageController;
  bool pageState = true;
  String requestState;
  String message;

  changePage(int index){
    _pageController.animateToPage(index,duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                        setState(() {
                          pageState = true;
                        });
                       changePage(0);
                    },
                    child: Container(
                      height: 60,
                      width: width * 0.4,
                      alignment: Alignment.center,
                      child: Text("Login", style: TextStyle(color: pageState ? Colors.white : Color(0xff150A42)),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                       ),
                        color: pageState ? Color(0xff150A42) : Colors.transparent,
                        border: Border.all(color: Color(0xff150A42), width: 1,style: BorderStyle.solid)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        pageState = false;
                      });
                      changePage(1);
                    },
                    child: Container(
                      height: 60,
                      width: width * 0.4,
                      alignment: Alignment.center,
                      child: Text("Register", style: TextStyle(color: pageState ? Color(0xff150A42) : Colors.white),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                        border: Border.all(color: Color(0xff150A42), width: 1,style: BorderStyle.solid),
                        color: pageState ? Colors.transparent : Color(0xff150A42),
                      ),
                      
                    ),
                  ),
                ],
              ),
              InfoTab(
                width: width * 0.8, 
                type: requestState,
                icon: Icon(Icons.info, color: Colors.white,),
                message: message,
                prefix: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 1,
                  )),
                ),
              SizedBox(height: 10,),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    LoginPart(),
                    RegisterPart()
                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
