import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/pageParts/configureTasks.part.dart';
import 'package:measur/pageParts/updateProject.part.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectCard extends StatelessWidget {
  FirebaseMethods firebaseMethods = FirebaseMethods();
  final String title;
  int daysLeft;
  final int progress;
  String startDate;
  String endDate;
  Map projectData = {};

  ProjectCard({this.projectData, @required this.startDate, @required this.endDate, @required this.title, @required this.progress});

  int getDaysLeft(){
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    String nowStr = "${now.year}${now.month >= 10 ? now.month : "0${now.month}"}${now.day >= 10 ? now.day : "0${now.day}"}";
    return end.difference(DateTime.parse(nowStr)).inDays;
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return UpdateProject(projectData: projectData);
        },
      )),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffffffff),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(title,overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            SizedBox(height: 5,),
                            Text( getDaysLeft() > 1
                                ? "${getDaysLeft()} days left"
                                : getDaysLeft() == 1 ? "Tomorrow" : "Today",
                              style: TextStyle(fontSize: 12),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.settings),
                              iconSize: 22,
                              onPressed: ()=>Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return ConfigureTasks(projectData: projectData);
                                },
                              )),
                            ),
                            CircularPercentIndicator(
                              radius: 20.0,
                              lineWidth: 3.0,
                              animation: true,
                              percent: (progress / 100),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: progress < 50 ? Colors.deepOrange : Color(0xff150A42),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ]
            )
          )
        ),
      ),
    );
  }
}