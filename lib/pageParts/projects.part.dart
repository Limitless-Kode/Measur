import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:measur/extensions/dateExtensions.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/providers/CustomerProvider.dart';
import 'package:measur/providers/ProjectProvider.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/widgets/customHeader.dart';
import 'package:measur/widgets/projectCard.dart';
import 'package:measur/widgets/projectStatisticsCard.dart';
import 'package:provider/provider.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final db = Firestore.instance;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  String currentUserID;



  getCustomers() async{
    await Provider.of<CustomerProvider>(context, listen: false).getCustomers();
  }

  getProjects() async{
    await Provider.of<ProjectProvider>(context, listen: false).getProjects();
  }
  getTasks() async{
    await Provider.of<TaskProvider>(context, listen: false).getTasks();
  }

  delete() async{
    await Provider.of<ProjectProvider>(context, listen: false).deleteProjects();
  }


  @override
  void initState() {
    super.initState();
    //delete();
    getCustomers();
    getProjects();
    getTasks();
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            CustomHeader(showSearch: false, title: "All Projects",addAction: ()=> Navigator.pushNamed(context, "/addProject"),),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.8,
                    child: Wrap(
                      spacing: 15,
                      children: <Widget>[
                        Consumer<CustomerProvider>(
                          builder: (context, provider, _) => ProjectStatisticsCard(
                            title: "Customers",
                            color: Color(0xff150A42),
                            icon: Icons.group,
                            number: provider.customers.length.toString(),
                          ),
                        ),

                        Consumer<ProjectProvider>(
                          builder: (context, provider, _) => ProjectStatisticsCard(
                              title: "Projects",
                              color: Color(0xff150A42),
                              icon: Icons.work,
                              number: provider.projects.length.toString(),
                          ),
                        ),
                        ProjectStatisticsCard(title: "Completed", color: Colors.deepOrange, icon: Icons.check_circle,),
                        Consumer<TaskProvider>(
                            builder : (context,provider,_) => ProjectStatisticsCard(
                                title: "Tasks",
                                color: Color(0xff150A42),
                                icon: Icons.group_work,
                                number: provider.tasks.length.toString(),
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),

                  Consumer<ProjectProvider>(
                    builder: (context, provider,_) => Column(
                      children: provider.projects.map((document){
                        if(!DateExt.endDateIsPast(dateTime: document["end_date"]))
                          return ProjectCard(
                            projectData: document,
                            title: document["project_title"],
                            progress: document["tasks"] == 0 ? 0 : ((document["completed"] / document["tasks"]) * 100).toInt(),
                            startDate: document["start_date"],
                            endDate: document["end_date"],
                          );
                        else return Container();
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}