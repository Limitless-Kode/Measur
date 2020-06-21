import 'dart:async';
import 'package:flutter/material.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/methods/validateForm.dart';
import 'package:measur/models/Customer.dart';
import 'package:measur/models/InfoMessage.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/providers/CustomerProvider.dart';
import 'package:measur/widgets/InputBox.dart';
import 'package:measur/widgets/Label.dart';
import 'package:measur/widgets/SubmitButton.dart';
import 'package:measur/widgets/infoTab.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
    FirebaseMethods firebaseMethods = FirebaseMethods();
    SQLiteMethods _sqLiteMethods = SQLiteMethods();

    InfoMessage info = InfoMessage();
    String gender = "male";
    Customer _customer = Customer();
    ValidateForm form = ValidateForm();
    Timer _timer;

    _onMessageEnd(){
      _timer = Timer(Duration(seconds: 3),(){
       setState(() {
         info.type = "";
       });
      });
    }

    @override
    void dispose() {
      _timer?.cancel();
      super.dispose();
    }

    addCustomer() async{
      setState(() {
        info.waiting = true;
        info.type = "info";
        info.message = "Adding details to your customer list...";
      });
      _customer.gender = gender;

      Response response = await _sqLiteMethods.newCustomer(_customer);
      await Provider.of<CustomerProvider>(context, listen: false).getCustomers();

      if(response.error){
        setState(() {
          info.waiting = false;
          info.type = "error";
          info.message = response.message;
        });
      }
      else{
        setState(() {
          info.waiting = false;
          info.type = "success";
          info.message = "${_customer.fullName} has been added";
        });
      }

      _onMessageEnd();

    }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            InfoTab(
              waiting: info.waiting,
              width: width * 0.8,
              type: info.type,
              icon: Icon(Icons.info, color: Colors.white,),
              message: info.message,
              prefix: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 1,
              )),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Label(text: "Personal Information", subtext: "Personal Information and contact details",),

                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                gender = "male";
                              });
                            },
                            child: Container(
                              height: 60,
                              width: width * 0.4,
                              alignment: Alignment.center,
                              child: Text("Male", style: TextStyle(color: gender == "male" ? Colors.white : Color(0xff150A42)),),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  color: gender == "male" ? Color(0xff150A42) : Colors.transparent,
                                  border: Border.all(color: Color(0xff150A42), width: 1,style: BorderStyle.solid)
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                gender = "female";
                              });
                            },
                            child: Container(
                              height: 60,
                              width: width * 0.4,
                              alignment: Alignment.center,
                              child: Text("Female", style: TextStyle(color: gender != "female" ? Color(0xff150A42) : Colors.white),),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
                                border: Border.all(color: Color(0xff150A42), width: 1,style: BorderStyle.solid),
                                color: gender != "female" ? Colors.transparent : Color(0xff150A42),
                              ),

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      InputBox(prefixIcon: Icon(Icons.person), label: "Full Name", onChanged: (value){
                        setState(() {
                          _customer.fullName = value.trim();
                        });
                      },),

                      InputBox(prefixIcon: Icon(Icons.call), label: "Phone", keyboardType: TextInputType.phone,
                      onChanged: (value){
                        setState(() {
                          _customer.phone = value.trim();
                        });
                      },),
                      InputBox(prefixIcon: Icon(Icons.home), label: "Address", onChanged: (value){
                        setState(() {
                          _customer.address = value.trim();
                        });
                      },),


                      SubmitButton(
                        label: "Add Customer",
                        icon: Icon(Icons.person_add, color: Colors.white,),
                        onPressed: () async{
                            Response validationResponse = await form.validatePersonalInfo(
                              address: _customer.address,
                              fullName: _customer.fullName,
                              phone: _customer.phone
                            );
                            if(!validationResponse.error){
                              await addCustomer();
                            }else{
                              setState(() {
                                info.waiting = false;
                                info.type = "error";
                                info.message = validationResponse.message;
                              });
                              _onMessageEnd();
                            }
                        },
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
}