import 'package:measur/methods/stringConstants.dart';

class Task{
  final String projectId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime dateTime;

  Task({this.projectId,this.title, this.startTime, this.endTime, this.dateTime});

  Map toMap(){
    Map<String, dynamic> data = {};
    data[PROJECT_ID] = this.projectId;
    data[TASK_TITLE] = this.title;
    data[START_TIME] = this.startTime;
    data[END_TIME] = this.endTime;
    data[TASK_DATE] = this.dateTime;

    return data;
  }

}