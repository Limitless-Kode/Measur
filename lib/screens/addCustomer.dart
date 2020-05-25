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

    _onMessageEnd(){
      Timer(Duration(seconds: 3),(){
       setState(() {
         info.type = "";
       });
      });
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
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
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
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                border: Border.all(color: Color(0xff150A42), width: 1,style: BorderStyle.solid),
                                color: gender != "female" ? Colors.transparent : Color(0xff150A42),
                              ),

                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      Label(text: "Personal Information", subtext: "Personal Information and contact details",),
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

                      SizedBox(height: 30,),
                      Label(text:"Body Measurements", subtext: "All measurements are in your specified units"),
                      Column(
                        children: <Widget>[
                          InputBox(
                            label: "Shoulder",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.shoulder = double.parse(value);
                              });
                            },
                          ),

                          gender == "female" ?
                          InputBox(
                            label: "Across Shoulder (Front)",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.acrossShoulderFront = double.parse(value);
                              });
                            },
                          ) : Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Across Shoulder (Back)",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.acrossShoulderBack = double.parse(value);
                              });
                            },
                          ) : Container(),
                          InputBox(
                            label: "Neck Circumference",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.neckCircumference = double.parse(value);
                              });
                            },
                          ),
                          gender == "female" ?
                          InputBox(
                            label: "Nape to Waist",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.napeToWaist = double.parse(value);
                              });
                            },
                          ) : Container(),
                          InputBox(
                            label: "Head Circumference",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.headCircumference = double.parse(value);
                              });
                            },
                          ),

                          InputBox(
                            label: "Cup Size",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.cupSize = double.parse(value);
                              });
                            },
                          ),

                          InputBox(
                            label: "Across Chest",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.acrossChest = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Across Back",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.acrossBack = double.parse(value);
                              });
                            },
                          ),
                          gender == "male" ? InputBox(
                            label: "Chest",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.chest = double.parse(value);
                              });
                            },
                          ): Container(),
                          gender == "female" ?
                          InputBox(
                            label: "Bust",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.bust = double.parse(value);
                              });
                            },
                          ): Container(),
                          gender == "female" ?
                          InputBox(
                            label: "Bust Point",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.bustPoint = double.parse(value);
                              });
                            },
                          ): Container(),
                          gender == "female" ?
                          InputBox(
                            label: "Bust Span",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.bustSpan = double.parse(value);
                              });
                            },
                          ): Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Under Bust Length",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.underBustLength = double.parse(value);
                              });
                            },
                          ): Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Under Bust Circumference",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.underBustCircumference = double.parse(value);
                              });
                            },
                          ): Container(),
                          InputBox(
                            label: "Waist",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.waist = double.parse(value);
                              });
                            },
                          ),
                          gender == "female" ?
                          InputBox(
                            label: "Waist To Hip",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.waistToHip = double.parse(value);
                              });
                            },
                          ): Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Waist To Knee",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.waistToKnee = double.parse(value);
                              });
                            },
                          ): Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Waist To Floor",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.waistToFloor = double.parse(value);
                              });
                            },
                          ): Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Waist To Ankle",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.waistToAnkle = double.parse(value);
                              });
                            },
                          ): Container(),

                          InputBox(
                            label: "Dress Length",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.dressLength = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Front Body Length",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.frontBodyLength = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Back Body Length",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.backBodyLength = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Hip",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.hip = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Thigh",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.thigh = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Inseam",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.inseam = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Out Seam",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.outSeam = double.parse(value);
                              });
                            },
                          ),
                          gender == "female"
                              ?
                          InputBox(
                            label: "Shoulder To Hip",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.shoulderToHip = double.parse(value);
                              });
                            },
                          ): Container(),
                          gender == "female"
                              ?
                          InputBox(
                            label: "Shoulder To Knee",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.shoulderToKnee = double.parse(value);
                              });
                            },
                          ): Container(),
                          gender == "female"
                              ?
                          InputBox(
                            label: "Shoulder To Floor",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.shoulderToFloor = double.parse(value);
                              });
                            },
                          ): Container(),

                          gender == "female"
                              ?
                          InputBox(
                            label: "Knee Circumference",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.kneeCircumference = double.parse(value);
                              });
                            },
                          ): Container(),

                           gender == "male" ? InputBox(
                            label: "Height",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.height = double.parse(value);
                              });
                            },
                          ) : Container(),

                          gender == "female" ?
                          InputBox(
                            label: "Band Height",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.bandHeight = double.parse(value);
                              });
                            },
                          ): Container(),
                          InputBox(
                            label: "Cuff",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.cuff = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Heel",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.heel = double.parse(value);
                              });
                            },
                          ),
                          InputBox(
                            label: "Crotch",
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                _customer.crotch = double.parse(value);
                              });
                            },
                          ),

                        ],
                      ),

                      SizedBox(height: 30,),
                      Label(text: "Sleeve Measurements", subtext: "Measurement for sleeves",),
                      InputBox(
                        label: "Bicep",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.bicep = double.parse(value);
                          });
                        },
                      ),

                      InputBox(
                        label: "Short Sleeve Length",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.shortSleeveLength = double.parse(value);
                          });
                        },
                      ),

                      InputBox(
                        label: "3/4 Sleeve Length",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.qtrSleeveLength = double.parse(value);
                          });
                        },
                      ),

                      InputBox(
                        label: "3/4 Sleeve Circumference",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.qtrSleeveCircumference = double.parse(value);
                          });
                        },
                      ),

                      InputBox(
                        label: "Long Sleev Length",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.longSleeveLength = double.parse(value);
                          });
                        },
                      ),

                      InputBox(
                        label: "Wrist Circumference",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.wristCircumference = double.parse(value);
                          });
                        },
                      ),

                      InputBox(
                        label: "Armhole",
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            _customer.armhole = double.parse(value);
                          });
                        },
                      ),

                      SubmitButton(
                        label: "Add Customer",
                        icon: Icon(Icons.person_add, color: Colors.white,),
                        onPressed: () async{
                          if(await firebaseMethods.isConnected()){
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
                          }else{
                            _onMessageEnd();
                            setState(() {
                              info.waiting = false;
                              info.type = "error";
                              info.message = "No internet Connection";
                            });
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