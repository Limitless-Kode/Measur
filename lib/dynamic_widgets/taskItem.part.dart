import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:measur/extensions/dateExtensions.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/widgets/taskItem.dart';
import 'package:provider/provider.dart';


class TaskItemPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider,_) => Container(
        child: Column(
            children: taskProvider.tasks.isNotEmpty ?
            taskProvider.tasks.map((task){
              return DateExt.endTimeIsPast(timestamp: Timestamp.fromDate(DateTime.parse(task[END_TIME]))) ? Container() :
              TaskItem(workingOn: isWorkingOn(startTime: task[START_TIME], endTime: task[END_TIME]),
                startTime: DateTime.parse(task[START_TIME]),
                endTime: DateTime.parse(task[END_TIME]),
                title: task[TASK_TITLE], difficulty: 1,);
            }).toList() : taskProvider.waiting ? [PlaceholderLines(count: 4, animate: true,)] : [Container()]
        ),
      ),
    );
  }

  bool isWorkingOn({startTime, endTime}) {
    TimeOfDay now = TimeOfDay.now();
    double nowTime = now.hour.toDouble() + (now.minute.toDouble() / 60);

    TimeOfDay startDate = TimeOfDay.fromDateTime(DateTime.parse(startTime));
    TimeOfDay endDate = TimeOfDay.fromDateTime(DateTime.parse(endTime));
    double _doubleStartDate = startDate.hour.toDouble() + (startDate.minute.toDouble() / 60);
    double _doubleEndDate = endDate.hour.toDouble() + (endDate.minute.toDouble() / 60);

    if(nowTime >= _doubleStartDate && nowTime <= _doubleEndDate) return true;
    else return false;
  }
}
