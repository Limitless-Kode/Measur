import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/InfoMessage.dart';
import 'package:measur/models/Milestone.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/providers/ProjectProvider.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/widgets/SubmitButton.dart';
import 'package:measur/widgets/dataCard.dart';
import 'package:measur/widgets/infoTab.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class UpdateProject extends StatefulWidget {
  final Map projectData;
  UpdateProject({this.projectData});

  @override
  _UpdateProjectState createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {
  SQLiteMethods _sqLiteMethods = SQLiteMethods();
  InfoMessage info = InfoMessage();
  List<Milestone> milestones = List();
  String newMilestone;
  TextEditingController controller = TextEditingController();
  bool waiting = true;
  Map<String, dynamic> project;


  @override
  void initState() {
    super.initState();
    project = Map<String, dynamic>.from(widget.projectData);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Project"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: width * 0.95,
          child: Column(
            children: <Widget>[
              InfoTab(
                width: width * 0.8,
                type: info.type,
                icon: Icon(Icons.info, color: Colors.white,),
                message: info.message,
                waiting: info.waiting,
                prefix: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 1,
                )),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text("General", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      subtitle: Text("General Project Information"),
                    ),
                    Divider(),
                    DataCard(title: "Project Title", subtitle: project["project_title"], inputType: TextInputType.text,
                      callBack: ({key, value}) => modalCallBack(false, key, value),
                    ),
                    DataCard(title: "Amount Paid", subtitle: project["amount_paid"].toString(),
                      callBack: ({key, value}) => modalCallBack(true, key, value),
                    ),
                    DataCard(
                      inputType: TextInputType.datetime,
                      title: "End Date",
                      subtitle: DateTime.parse(project["end_date"]).toString().split(" ")[0],
                      callBack: ({key, value}){
                        try{
                          DateTime.parse(value);
                          modalCallBack(false, key, value);
                        }catch(err){
                          //show error
                          showToast(true, "The date you entered is invalid");
                        }
                      },
                    ),
                    project[SYNC] == 1 ? Container()
                        : SizedBox(
                        width: width * 0.8,
                        child: SubmitButton(label: "Synchronize", icon: Icon(Icons.update, color: Colors.white,), onPressed: ()=> null,)
                    ),

                    Consumer<TaskProvider>(
                      builder: (context, provider, _){
                        return provider.tasks.where((task) => task[PROJECT_ID] == widget.projectData[PROJECT_ID]).length > 0 ? Container(
                          child: Column(
                            children: <Widget>[
                              ListTile(title: Text("Tasks", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), subtitle: Text("These are the tasks you have for this project"),),
                              SizedBox(height: 15,),
                              Column(
                                children: provider.tasks.where((task) => task[PROJECT_ID] == widget.projectData[PROJECT_ID]).map((task) =>
                                   Column(
                                     children: <Widget>[
                                       Container(
                                         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                         child: Row(
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: <Widget>[
                                             Container(
                                               height: 10,
                                               width: 10,
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(10),
                                                   color: task[TASK_STATE] == 0 ? Colors.blue : task[TASK_STATE] == 1 ? Colors.orange : Colors.green
                                               ),
                                               alignment: Alignment.centerLeft,
                                             ),
                                             SizedBox(width: 15),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: <Widget>[
                                                 SizedBox(
                                                   width: width * 0.7,
                                                     child: Text(task[TASK_TITLE],
                                                       overflow: TextOverflow.clip,
                                                       style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),)
                                                 ),
                                                 SizedBox(height: 5,),
                                                 Text("Today"),
                                               ],
                                             ),
                                           ],
                                         ),
                                       ),
                                       Divider()
                                     ],
                                   ),
                                ).toList(),
                              )
                            ],
                          ),
                        ) : Container();
                      },
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  modalCallBack(bool isNumber, key, value) async{
    Response response = Response();

    //sending a request to update field
    response = await _sqLiteMethods.updateProject(isNumber, key, value, project[PROJECT_ID]);
    Provider.of<ProjectProvider>(context, listen: false).getProjects();

    //show a toast message
    Toast.show(response.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,
        backgroundColor: response.error ? Colors.red : Color(0xff150A42));

    //format key to match key in firestore
    String formattedKey = key.trim().split(" ").join("_").toLowerCase();

    var parsedValue;

    //check if value is a number or a string and assign the appropriate value
    isNumber ? parsedValue = double.parse(value) : parsedValue = value;

    //set item to the new value
    setState(() {
      project[formattedKey] = parsedValue;
    });
  }

  showMessage({String text}){
    setState(() {
      info.waiting = false;
      info.message = text;
    });
    Timer(Duration(seconds: 3),(){
      setState(() {
        info.type = "";
        info.message = "";
      });
    });
  }

  void showToast(bool error, String message) {
    Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,
        backgroundColor: error ? Colors.red : Color(0xff150A42));
  }
}
