import 'package:flutter/material.dart';

class CustomerCard extends StatefulWidget {
  final String name;
  final String phone;
  final Function onTap;

  CustomerCard({@required this.name, @required this.phone, this.onTap});

  @override
  _CustomerCardState createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  bool showEdit = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1))
            ),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: widget.onTap,
                onLongPress: (){
                  setState(() {
                    showEdit = true;
                  });
                },
                child: ListTile(
                  title: Text(widget.name,style: TextStyle(fontSize: 18),),
                  subtitle: Text(widget.phone),
                  leading: InkWell(
                    onTap: ()=> print("Show details"),
                    child: Container(height: 45, width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.withOpacity(0.3)
                    ),
                    child: Text(widget.name[0],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),)
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1))
          ),
          child: showEdit ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff150A42),
                  ),
                  height: 35, 
                  width: 35, 
                  child: Icon(Icons.edit, color: Colors.white,),
                ),
                SizedBox(width: 10,),
                Text("Edit")
                ],
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    showEdit = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xff150A42),
                  ),
                  height: 35, 
                  width: 35, 
                  child: Icon(Icons.clear, color: Colors.white,)
                ),
              ),
            ],
          ) : SizedBox(),
        )

      ],
    );
  }
}