import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotFound extends StatelessWidget {
  final Function callback;
  final String description;
  NotFound({this.callback, this.description = ""});
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
          Image.asset("resources/images/empty1.png",width: width * 0.8,),
          SizedBox(
            width: 240,
              child: Text(description,textAlign: TextAlign.center,)
          ),
          SizedBox(height: 30,),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Color(0xff150A42).withOpacity(0.2),
              borderRadius: BorderRadius.circular(50)
            ),
            child: IconButton(
              color: Color(0xff150A42).withOpacity(0.5),
              icon: Icon(Icons.add),
              iconSize: 22,
              onPressed: callback,
            ),
          )
        ],
      ),
    );
  }
}
