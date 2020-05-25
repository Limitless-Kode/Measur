import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:measur/widgets/InputBox.dart';

class DataCard extends StatefulWidget {
  TextInputType inputType;
  final String title;
  String subtitle;
  String empty;
  void Function({String key, String value}) callBack;

  DataCard({this.inputType = TextInputType.number, this.callBack, @required this.title, @required this.subtitle, this.empty = "Measurement not taken"});

  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  bool waiting = false;

  _displayDialog(BuildContext context) async {
    String value;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Text("Update"),
            content: InputBox(
              controller: TextEditingController()..text = widget.subtitle != "null" ? widget.subtitle.toString() : "",
              label: widget.title,
              keyboardType: widget.inputType,
              vMargin: 0,
              onChanged: (entered){
                setState(() {
                  value = entered;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                color: Color(0xff150A42),
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                child: Text('Update'),
                onPressed: () async{
                  Navigator.of(context).pop();
                  if(value != null) {
                    setState(() {
                      waiting = true;
                    });

                    widget.callBack(key: widget.title, value: value);
                    //widget.onChanged(formattedKey, value);
                    setState(() {
                      waiting = false;
                    });
                  }
                },
              ),
              FlatButton(
                child: Text('Cancel', style: TextStyle(color: Color(0xff150A42)),),
                onPressed: ()=> Navigator.of(context).pop()
              )
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.title),
            subtitle: Text((widget.subtitle != "null") ? widget.subtitle : widget.empty,
            style: TextStyle(color: widget.subtitle != "null" ? Colors.black : Colors.red),
            ),
            leading: widget.subtitle != "null" ? null : Icon(Icons.info, color: Colors.orange,),
            trailing: waiting ? Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xff150A42)),
              )
            )
                : IconButton(icon: Icon(Icons.update),
              onPressed: ()=> _displayDialog(context),),
          ),
          Divider()
        ],
      ),
    );
  }
}
