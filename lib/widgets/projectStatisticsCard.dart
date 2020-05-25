import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectStatisticsCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String number;
  final String title;

  ProjectStatisticsCard({this.color, this.icon, this.number = "0", this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      width: width * 0.38,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(icon,color: Colors.white,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(number, style: TextStyle(color: Colors.white, fontSize: 22),),
              Text(title, style: TextStyle(color: Colors.white),),
            ],
          )
        ],
      )
    );
  }
}
