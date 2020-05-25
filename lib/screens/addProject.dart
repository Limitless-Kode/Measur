import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/InfoMessage.dart';
import 'package:measur/models/Project.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/providers/CustomerProvider.dart';
import 'package:measur/providers/ProjectProvider.dart';
import 'package:measur/widgets/InputBox.dart';
import 'package:measur/widgets/Label.dart';
import 'package:measur/widgets/SubmitButton.dart';
import 'package:measur/widgets/filterBox.dart';
import 'package:measur/widgets/infoTab.dart';
import 'package:provider/provider.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}



class _AddProjectState extends State<AddProject> {
    InfoMessage infoMessage = InfoMessage();
    String gender = "male";
    String startDate;
    String endDate;
    List<dynamic> customerList = [];
    List customers;
    bool dataLoaded = false;
    Project _project = Project();
    ScrollController _scrollController = ScrollController();
    FirebaseMethods firebaseMethods = FirebaseMethods();
    SQLiteMethods _sqLiteMethods = SQLiteMethods();

    Future<String> showPicker( bool first, BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: startDate == null && first
              ? DateTime.now()
              : DateTime.parse(startDate),

          firstDate: startDate != null && !first
              ? DateTime.parse(startDate)
              : DateTime.now(),

          lastDate: DateTime.now().add(Duration(days: 365))
      );

      String date;
      if(picked != null){
        date = picked.toString().split(" ")[0];
      }
      if(first){
        setState(() {
          endDate = null;
        });
      }
      return date;
    }

    void getCustomerList() async{
      customers = Provider.of<CustomerProvider>(context, listen: false).customers;

      customers.forEach((element) {
        Map customer = {};
        customer[CUSTOMER_ID] = element[CUSTOMER_ID];
        customer[FULL_NAME] = element[FULL_NAME];
        customer[PHONE] = element[PHONE];
        customerList.add(customer);
      });


      setState(() {
        dataLoaded = true;
      });

    }

    @override
  void initState() {
    super.initState();
    getCustomerList();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Project"),
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
                controller: _scrollController,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 10,),

                      SizedBox(height: 10),
                      Label(text: "General", subtext: "General project information.",),
                      FilterBox(
                        suggestedList: customerList,
                        label: "Choose Customer",
                        enabled: dataLoaded,
                        setCustomer: (customerId){
                          print(customerId);
                          setState(() {
                            _project.customerId = customerId;
                          });
                        },
                      ),
                      InputBox(
                        prefixIcon: Container(margin: EdgeInsets.all(12),
                        child: FaIcon(FontAwesomeIcons.tape, size: 18,)),
                        label: "Project Title",
                        onChanged: (value){
                          setState(() {
                            _project.projectTitle = value;
                          });
                        },
                      ),

                      SizedBox(height: 30,),
                      Label(text: "Cost", subtext: "How much the project would cost and how much your customer has paid.",),
                      InputBox(
                        keyboardType: TextInputType.number,
                        prefixIcon: Icon(Icons.account_balance_wallet,),
                        label: "Total Cost",
                        onChanged: (value){
                          setState(() {
                            _project.totalCost = double.parse(value);
                          });
                        },
                      ),
                      InputBox(
                        keyboardType: TextInputType.number,
                        prefixIcon: Container(margin: EdgeInsets.all(12),
                            child: FaIcon(FontAwesomeIcons.piggyBank, size: 18,)),
                        label: "Amount Paid",
                        onChanged: (value){
                          setState(() {
                            _project.amountPaid = double.parse(value);
                          });
                        },
                      ),

                      SizedBox(height: 30,),
                      Label(text: "Timelines", subtext: "Set your start and completion date of this project",),
                      Container(
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InputBox(
                              prefixIcon: Icon(Icons.date_range),
                              label: "Start Date",
                              controller: TextEditingController()..text = startDate,
                              width: width / 2.7,
                              readOnly: true,
                              onTap: ()async{
                                String date = await showPicker(true,context);
                                setState(() {
                                  startDate = date;
                                  _project.startDate = DateTime.parse(date);
                                });
                              },
                            ),
                            InputBox(
                              prefixIcon: Icon(Icons.date_range),
                              enabled: startDate != null ? true : false,
                              label: "End Date",
                              controller: TextEditingController()..text = endDate,
                              width: width / 2.7,
                              readOnly: true,
                              onTap: ()async{
                                String date = await showPicker(false,context);
                                setState(() {
                                  endDate = date;
                                  _project.endDate = DateTime.parse(date);
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      SubmitButton(
                        label: "Add Project",
                        icon: Icon(Icons.work, color: Colors.white,),
                        onPressed: () => addProject(_project),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


    addProject(Project project) async{
      setState(() {
        infoMessage.waiting = true;
        infoMessage.message = "Adding project";
        infoMessage.type = "info";
      });

      Response response = await _sqLiteMethods.newProject(project);
      Provider.of<ProjectProvider>(context, listen: false).getProjects();

      setState(() {
        infoMessage.waiting = false;
        infoMessage.message = response.message;
        infoMessage.type = response.error ? "error" : "info";
      });
    }

}
