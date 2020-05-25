import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:measur/extensions/dateExtensions.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/Task.dart';

class TaskProvider with ChangeNotifier{
  FirebaseMethods firebaseMethods = FirebaseMethods();
  List<Timestamp> _dates = [];
  bool _waiting = true;
  List<Map<String, dynamic>> _tasks = [];
  SQLiteMethods _sqLiteMethods = SQLiteMethods();

  List<Map<String, dynamic>> get tasks => _tasks;

  List<Timestamp> get dates => _dates;

   bool get waiting => _waiting;

   set waiting(bool value) => _waiting = value;




   //get tasks from sqlite database
  Future<List<Map<String, dynamic>>> getTasks() async{
    _tasks = [];
    DateTime todayNow = DateTime.now();

    List response = await _sqLiteMethods.getTasks();
    //print(response);

    await Future.forEach(response, (task){
      _dates.add(Timestamp.fromDate(DateTime.parse(task[TASK_DATE])));
      DateTime taskDate = DateTime.parse(task[END_TIME]);
      //print("${task[TASK_TITLE]} End Date: $taskDate == $todayNow");
      if(taskDate.isAfter(todayNow) &&
          (taskDate.year == todayNow.year && taskDate.month == todayNow.month && taskDate.day == todayNow.day)
      ) tasks.add(task);

    });

    notifyListeners();
    return tasks;
  }

  addTask({title,dateTime,endTime,startTime, projectId}) async{
    Task task = Task(title: title,dateTime: DateTime.parse(dateTime), endTime: endTime, startTime: startTime,projectId: projectId);
    Map SQLTask = task.toMap();
    SQLTask[TASK_DATE] = task.dateTime.toString();
    SQLTask[START_TIME] = task.startTime.toString();
    SQLTask[END_TIME] = task.endTime.toString();
    SQLTask[PROJECT_ID] = task.projectId.toString();
    SQLTask[TASK_STATE] = 0;

    if(await firebaseMethods.isConnected()){
      await firebaseMethods.addTask(task: task, projectId: projectId);
      SQLTask[SYNC] = 1;
      await _sqLiteMethods.newTask(SQLTask);
      tasks.add(SQLTask);
    }else{
      SQLTask[SYNC] = 0;
      await _sqLiteMethods.newTask(SQLTask);
      tasks.add(SQLTask);
    }

    notifyListeners();
  }

  List<Map<String, dynamic>> ongoingTasks = [];
  getOngoingTask(){
    ongoingTasks = [];
    TimeOfDay now = TimeOfDay.now();
    double nowTime = now.hour.toDouble() + (now.minute.toDouble() / 60);

    tasks.where((datetime){
      TimeOfDay startDate = TimeOfDay.fromDateTime(DateTime.parse(datetime["start_time"]));
      TimeOfDay endDate = TimeOfDay.fromDateTime(DateTime.parse(datetime["end_time"]));
      double _doubleStartDate = startDate.hour.toDouble() + (startDate.minute.toDouble() / 60);
      double _doubleEndDate = endDate.hour.toDouble() + (endDate.minute.toDouble() / 60);

      if(nowTime >= _doubleStartDate && nowTime <= _doubleEndDate) return true;
      else return false;
    }).forEach((element) {
      ongoingTasks.add(element);
    });

    notifyListeners();
  }

}