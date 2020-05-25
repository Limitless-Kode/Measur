import 'package:flutter/material.dart';

class FreeNow extends StatelessWidget {
  String text;
  Function callback;
  FreeNow({@required this.text, this.callback});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
          Image.asset("resources/images/free.png",width: width * 0.9,),
        ],
      ),
    );
  }
}
