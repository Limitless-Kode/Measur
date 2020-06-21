import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:provider/provider.dart';


class CurrentTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<TaskProvider>(
      builder: (context, taskProvider,_) => Container(
        child: taskProvider.ongoingTasks.isEmpty ?
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.8,
                    child: Image.asset("resources/images/rest.png")
                  ),
                  SizedBox(
                      width: width * 0.8,
                      child: Text("You can take a rest, you have no work at the moment.",
                        textAlign: TextAlign.center,
                      )
                  )

                ]
            )
        )
        : Column(
          children: taskProvider.ongoingTasks.map((task){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Color(0xff150A42),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                    children: <Widget>[
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  height: 10, width: 10,
                                  margin: EdgeInsets.symmetric(vertical:5),
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(25))
                              ),
                              SizedBox(width: 5,),
                              Text("Currently", style: TextStyle(fontSize: 12, color: Colors.white),)
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.access_time, size: 12, color: Colors.white,),
                              SizedBox(width: 5,),
                              Text(
                                spitDuration(
                                    startTime: task["start_time"],
                                    endTime: task["end_time"]
                                ),
                                style: TextStyle(color: Colors.white),)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.6,
                            child: Text(task[TASK_TITLE],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.today, color: Colors.deepOrange,)
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 5,),
                    ]
                )
            );
          }).toList(),
        ),
      )
    );
  }

  String spitDuration({startTime, endTime}) {
    String duration = "";

    TimeOfDay startDate = TimeOfDay.fromDateTime(DateTime.parse(startTime));
  //  TimeOfDay endDate = TimeOfDay.fromDateTime(DateTime.parse(endTime));
    TimeOfDay endDate = TimeOfDay.fromDateTime(DateTime.now());

    int _doubleStartDate = (startDate.hour * 60) + (startDate.minute);
    int _doubleEndDate = (endDate.hour * 60) + (endDate.minute);

    int totalMinsLeft = _doubleStartDate - _doubleEndDate;
    int hour = (totalMinsLeft / 60).floor();
    int mins = (totalMinsLeft % 60).floor();

    hour >= 1 ?? hour == 1 ? duration += "1 hr " : hour == 0 ? duration+="" : hour < 1 ? "" : duration += "$hour hrs ";
    mins != 0 ?? mins > 10 ? duration += "$mins mins" : mins == 0 ? duration += "" : duration += "0$mins mins";


    return duration;
  }
  
}