import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:measur/widgets/InputBox.dart';


class Milestone extends StatefulWidget {
  bool isLastChild;
  Function(int index) onPressed;
  Function onChanged;
  int index;

  Milestone({this.isLastChild = true, this.onPressed, this.index = 0, this.onChanged});

  @override
  _MilestoneState createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InputBox(
            width: widget.isLastChild ? width * 0.63 : width * 0.8,
            prefixIcon: Container(margin: EdgeInsets.all(12), child: Icon(Icons.work,)),
            label: "Milestone #${widget.index + 1}",
            onChanged: widget.onChanged
          ),
          widget.isLastChild ? Container(
            height: width * 0.15,
            width: width * 0.15,
            decoration: BoxDecoration(
              color: Color(0xff150A42),
              borderRadius: BorderRadius.circular(5)
            ),
            child: IconButton(
              iconSize: 26,
              onPressed: (){
                widget.onPressed(widget.index);
                setState((){});

              },
              icon: Icon(Icons.add, color: Colors.white,),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
