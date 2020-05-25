import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/methods/stringMethods.dart';
import 'package:measur/models/Customer.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/widgets/dataCard.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetails extends StatefulWidget{
final Map customer;

CustomerDetails({@required this.customer});
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();

}

class _CustomerDetailsState extends State<CustomerDetails> {
  String nameLabel;
  @override
  Widget build(BuildContext context) {
    double height  = MediaQuery.of(context).size.height;
    double width  = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: height / 2,
                floating: false,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Mobile"),
                                  SizedBox(height: 5,),
                                  Text(widget.customer["phone"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(icon: Icon(Icons.call, color: Color(0xff150A42),), onPressed: ()=> launch("tel://${widget.customer['phone']}"),),
                                  IconButton(icon: Icon(Icons.message, color: Colors.orangeAccent,), onPressed: ()=> launch("sms://${widget.customer['phone']}?body=Hello ${widget.customer['full_name']}, "),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Color(0xff150A42),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Color(0xffffffff).withOpacity(0.5),
                            ),
                            child: Text(widget.customer["full_name"][0],
                              style: TextStyle(color: Color(0xff150A42),fontSize: 36,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("${widget.customer['full_name']}", style: TextStyle(color: Colors.white, fontSize: 22),)
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: width * 0.8,
                  margin: EdgeInsets.all(10),
                  height: 10.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return Text("");
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(customerMeasurements()),
              ),
            ],
          ),
        )
      ),
    );
  }

  List<Widget> customerMeasurements() {
    StringMethods stringMethods = StringMethods();
    List<Widget> widgets = [];
    Map customerInfo = {};

    customerInfo.addAll(widget.customer);
    Customer _customer = Customer();

    if(customerInfo[GENDER] == "male") customerInfo = _customer.toMaleMeasurement(customerInfo);
    else customerInfo = _customer.toFemaleMeasurement(customerInfo);

    customerInfo.forEach((key, value) {
      String formattedKey = stringMethods.formatKey(key);
      widgets.add(DataCard(
        title: formattedKey,
        subtitle: value.toString() ,
        callBack: ({key, value}) => modalCallBack(key, value)
      ));
    });

    return widgets;
  }

  modalCallBack(key , value) async{
    FirebaseMethods _firebaseMethods = FirebaseMethods();

    Response response = Response();

    //firebase update
    response = await _firebaseMethods.updateMeasurement(key, value, widget.customer[CUSTOMER_ID]);

    Toast.show(response.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,
        backgroundColor: response.error ? Colors.red : Color(0xff150A42));

    //format key to match key in firestore
    String formattedKey = key.trim().split(" ").join("_").toLowerCase();

    setState(() {
      widget.customer[formattedKey] = double.parse(value);
    });
  }

}