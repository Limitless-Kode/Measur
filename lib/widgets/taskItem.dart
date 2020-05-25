import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final DateTime endTime;
  final DateTime startTime;
  final bool workingOn;
  final int difficulty;
  TaskItem({@required this.title, @required this.startTime, @required this.endTime, @required this.workingOn, @required this.difficulty});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
        subtitle: Text("${TimeOfDay.fromDateTime(startTime).format(context)} - ${TimeOfDay.fromDateTime(endTime).format(context)}",style: TextStyle(fontSize: 12),),
        leading: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(color: difficulty > 5 ? Colors.deepOrange : workingOn ? Colors.grey :Color(0xff150A42), width: 2),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            Positioned(
              bottom: -1.5,
              right: -1.5,
              child: Container(
                height: 10,
                width: 10,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: difficulty > 5 ? Colors.deepOrange : workingOn ? Colors.grey : Color(0xff150A42),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ],
        ),
        trailing: workingOn ? Icon(Icons.access_time) : Container(height: 10,width: 10,),
      ),
    );
  }
}