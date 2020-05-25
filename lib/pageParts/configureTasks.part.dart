import 'dart:async';
import 'package:flutter/material.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/InfoMessage.dart';
import 'package:measur/models/Milestone.dart';
import 'package:measur/providers/NotificationProvider.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/widgets/InputBox.dart';
import 'package:measur/widgets/Label.dart';
import 'package:measur/widgets/SubmitButton.dart';
import 'package:measur/widgets/infoTab.dart';
import 'package:provider/provider.dart';

class ConfigureTasks extends StatefulWidget {
  final Map projectData;
  ConfigureTasks({this.projectData});
  @override
  _ConfigureTasksState createState() => _ConfigureTasksState();
}

class _ConfigureTasksState extends State<ConfigureTasks> {
  String dropdownValue = 'One';
  FirebaseMethods firebaseMethods = FirebaseMethods();
  List<Milestone> milestones;
  String task;
  String date;
  TimeOfDay endTime;
  TimeOfDay startTime;
  InfoMessage infoMessage = InfoMessage();


  @override
  void initState() {
    super.initState();
  }


  addTask() async{
    if(date == null){
      showMessage(message: "Please pick a date", type: "error");
    }else if(startTime == null || endTime == null){
      showMessage(message: "Please select your start and end time", type: "error");
    }else if(task == null || task.trim() == ""){
      showMessage(message: "Task cannot be empty", type: "error");
    }else{
      DateTime pDate = DateTime.parse(date);
      await Provider.of<TaskProvider>(context, listen: false).addTask(
        startTime: DateTime(pDate.year, pDate.month, pDate.day, startTime.hour, startTime.minute),
        endTime: DateTime(pDate.year, pDate.month, pDate.day, endTime.hour, endTime.minute),
        dateTime: date,
        title: task,
        projectId: widget.projectData[PROJECT_ID],
      );

      await Provider.of<NotificationProvider>(context, listen: false).scheduleNotificationWithSound(
        scheduledNotificationDateTime: DateTime(pDate.year, pDate.month, pDate.day, startTime.hour, startTime.minute).subtract(Duration(minutes: 5)),
        payload: "task_reminder",
        title: "Reminder",
        body: "You will start your next task in 5 minutes"
      );

      await Provider.of<NotificationProvider>(context, listen: false).scheduleNotificationWithSound(
          scheduledNotificationDateTime: DateTime(pDate.year, pDate.month, pDate.day, startTime.hour, startTime.minute),
          payload: "task_reminder",
          title: task,
          body: "Hey it's time, you've got to switch now"
      );

    }
  }

  showMessage({message, type}){
    setState(() {
      infoMessage.type = type;
      infoMessage.message = message;
      infoMessage.waiting =  false;
    });

    Timer(Duration(seconds: 3),(){
      setState(() {
        infoMessage.type = "";
      });
    });
  }

  Future<String> showPicker( bool first, BuildContext context) async {
    DateTime firstDate = DateTime.parse(widget.projectData[START_DATE]);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().isBefore(firstDate) ?  firstDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: DateTime.parse(widget.projectData[END_DATE])
    );

    String date;
    if(picked != null){
      date = picked.toString().split(" ")[0];
    }

    return date;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure Tasks"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            InfoTab(
              width: width * 0.8,
              type: infoMessage.type,
              icon: Icon(Icons.info, color: Colors.white,),
              message: infoMessage.message,
              waiting: infoMessage.waiting,
              prefix: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 1,
              )),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: width * 0.8,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: <Widget>[
                          Label(text: "Add Task", subtext: "Add a new task for this project.",),

                          InputBox(
                            label: "Enter Task",
                            prefixIcon: Icon(Icons.group_work),
                            onChanged: (value)=> setState(()=> task = value),
                          ),
                          InputBox(
                            prefixIcon: Icon(Icons.date_range),
                            label: "Pick a date",
                            controller: TextEditingController()..text = this.date,
                            readOnly: true,
                            onTap: ()async{
                              String date = await showPicker(true,context);
                              setState(() {
                                this.date = date;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InputBox(
                                  width: width / 2.7,
                                  prefixIcon: Icon(Icons.directions_run),
                                  label: "Start Time",
                                  controller: TextEditingController()..text = startTime == null ? "" : startTime.format(context).toString(),
                                  readOnly: true,
                                  onTap: ()async{
                                    final TimeOfDay picked =
                                    await showTimePicker(context: context, initialTime: TimeOfDay.now());

                                    if(picked != null){
                                      setState(() {
                                        startTime = picked;
                                      });
                                    }
                                  }
                              ),
                              InputBox(
                                  width: width / 2.7,
                                  prefixIcon: Icon(Icons.directions_transit),
                                  label: "End Time",
                                  enabled: startTime != null ? true : false,
                                  controller: TextEditingController()..text = endTime == null ? "" : endTime.format(context).toString(),
                                  readOnly: true,
                                  onTap: () async{
                                    final TimeOfDay picked =
                                    await showTimePicker(context: context, initialTime: startTime);

                                    if(picked != null){
                                      setState(() {
                                        endTime = picked;
                                      });
                                    }
                                  }
                              ),
                            ],
                          ),
                          SubmitButton(
                              label: "Add Task",
                              icon: Icon(Icons.group_work, color: Colors.white,),
                              onPressed: ()=> addTask()
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}