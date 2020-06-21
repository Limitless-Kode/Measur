import 'package:measur/methods/stringConstants.dart';

class Task{
  String project_id;
  String task_title;
  int task_state;
  DateTime start_time;
  DateTime end_time;
  DateTime date_time;

  Task({this.project_id,this.task_title, this.start_time, this.end_time, this.date_time});

  Map toMap(){
    Map<String, dynamic> data = {};
    data[PROJECT_ID] = this.project_id;
    data[TASK_TITLE] = this.task_title;
    data[START_TIME] = this.start_time;
    data[END_TIME] = this.end_time;
    data[TASK_DATE] = this.date_time;
    data[TASK_STATE] = this.task_state;
    return data;
  }

  Task fromMap(Map<String, dynamic> map){
    this.project_id = map[PROJECT_ID];
    this.task_title = map[TASK_TITLE];
    this.start_time = DateTime.parse(map[START_TIME]);
    this.end_time = DateTime.parse(map[END_TIME]);
    this.date_time = DateTime.parse(map[TASK_DATE]);
    this.task_state = map[TASK_STATE];
  }

}