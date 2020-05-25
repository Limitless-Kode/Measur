import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final String dayOfWeek;
  final String dayOfMonth;
  final bool today;

  DateCard({@required this.dayOfMonth, @required this.dayOfWeek, @required this.today});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 60,
        height: 60,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          elevation: 0,
          color: today ? Colors.deepOrange : Colors.deepOrange.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(dayOfWeek,style: TextStyle(letterSpacing: 1,color: today ? Colors.white : Colors.deepOrange),),
              SizedBox(height: 2,),
              Text(dayOfMonth,style: TextStyle(fontSize: 14, color: today ? Colors.white : Colors.deepOrange, fontWeight: FontWeight.bold)),
            ],
        ),
          ),
      ),
    ),
    );
  }
}