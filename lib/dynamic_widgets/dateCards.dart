import 'package:flutter/material.dart';
import 'package:measur/extensions/dateExtensions.dart';
import 'package:measur/methods/stringMethods.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/widgets/dateCard.dart';
import 'package:provider/provider.dart';

class DateCards extends StatelessWidget {
  final StringMethods stringMethods = StringMethods();
  final List dates;
  List<DateTime> formattedDates = [];
  DateCards({this.dates});

  List<DateTime> parseTimestamps(){
    formattedDates = [];
    List newList = dates.toSet().toList();

    Future.forEach(newList, (timestamp){
      DateTime date = timestamp.toDate();

      int dateDiff = DateExt.compare(initialDate: DateTime.now(), otherDate: date);

      if(dateDiff >= 0)
        formattedDates.add(date);
    });
    formattedDates.sort();
    return formattedDates;
  }

  bool isToday(datetime){
    if(DateExt.compare(initialDate: datetime,otherDate: DateTime.now()) == 0)
      return true;
    else return false;
  }

  @override
  Widget build(BuildContext context) {
    parseTimestamps();
    return  Consumer<TaskProvider>(
      builder: (context, taskProvider, _ )=> Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: taskProvider.tasks.isNotEmpty ? 30 : 10),
        height: 60,
        child: taskProvider.tasks.isNotEmpty ? ListView(
            scrollDirection: Axis.horizontal,
            children:
            parseTimestamps().map((datetime) => DateCard(
              dayOfMonth: datetime.day.toString(),
              dayOfWeek: stringMethods.days[datetime.weekday - 1],
              today: isToday(datetime),
            ),).toList()
        )
            : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xff150A42).withOpacity(0.1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: <Widget>[
                Icon(Icons.beach_access),
                SizedBox(width: 15,),
                Text("You don't seem to have any scheduled task"),
              ],
            )
        ),
      ),
    );
  }
}