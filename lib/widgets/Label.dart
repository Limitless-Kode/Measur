import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Label extends StatelessWidget {
  final String text;
  final String subtext;
  Label({@required this.text, this.subtext = "" });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              SizedBox(
                width: width * 0.8,
                  child: Text(subtext, style: TextStyle(color: Colors.grey))
              ),
              SizedBox(height: 20,),
            ],
          ),
        ],
      ),
    );
  }
}