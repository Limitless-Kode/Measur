import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  String type;
  final String message;
  final Widget icon;
  final Widget prefix;
  final double width;
  bool waiting;

  InfoTab({@required this.type, @required this.message, @required this.icon, @required this.width, @required this.prefix, this.waiting = true});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (type) {
      case "info":
        color = Color(0xff150A42);
        break;
      case "error":
        color = Colors.red;
        break;
      case "success":
        color = Color(0xff150A42);
        break;
      default:
        return Container();
    }

    return SizedBox(
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        height: 35,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                icon,
                SizedBox(width: 10,),
                Text(message, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
              ],
            ),
            waiting ? prefix : Container()
          ],
        ),
      ),
    );
  }
}