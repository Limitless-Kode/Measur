import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:measur/dynamic_widgets/dateCards.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/stringMethods.dart';
import 'package:measur/dynamic_widgets/taskItem.part.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/widgets/currentTask.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  Map date = {};
  final StringMethods stringMethods = StringMethods();
  FirebaseMethods firebaseMethods = FirebaseMethods();
  List<Map<String, dynamic>> tasks = [];
  List<Timestamp> dates = [];
  RefreshController _refreshController = RefreshController(initialRefresh: true);


  getTasks() async{
    await Provider.of<TaskProvider>(context, listen: false).getTasks();
    await Provider.of<TaskProvider>(context, listen: false).getOngoingTask();
    Provider.of<TaskProvider>(context, listen: false).waiting = false;
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
   // getTasks();
    super.initState();
    setState(() => date = stringMethods.getDate());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SmartRefresher(
        header: WaterDropMaterialHeader(),
        controller: _refreshController,
        onRefresh: getTasks,
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            Text("${date['date']}"),
            SizedBox(height: 10,),
            Text("Daily Task", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),

            Consumer<TaskProvider>(
              builder: (context, taskProvider, _) => DateCards(dates: taskProvider.dates,),
            ),
            CurrentTask(),
            SizedBox(height: 30,),
            Column(
              children: <Widget>[
                TaskItemPart(),
              ],
            )
          ],
        ),
      ),
    );
  }
}