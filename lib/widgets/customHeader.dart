import 'package:flutter/material.dart';
import 'package:measur/widgets/SearchInputBox.dart';

class CustomHeader extends StatefulWidget {
  final String title;
  final Function addAction;
  final Function onChanged;
  final bool showSearch;
  CustomHeader({@required this.title, @required this.addAction, this.onChanged, this.showSearch = true});

  @override
  _CustomHeaderState createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(1.0, 6.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _search ? Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff150A42),),
                height: 40,
                width: 40,
                child: IconButton(
                  splashColor: Colors.white.withOpacity(0.5),
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    setState(() {
                      _search = false;
                    });
                  },
                ),
              ) : Container(),
              _search ? Container(
                child: SearchInputBox(label: "Find Customer", prefixIcon: Icon(Icons.search), onChanged: widget.onChanged,),
              ) : Text(widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
            ],
          ),

          Row(
            children: <Widget>[
              _search
                  ? Container()
                  : Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff150A42),),
                height: 40,
                width: 40,
                child: IconButton( splashColor: Colors.white.withOpacity(0.5), icon: Icon(Icons.add, color: Colors.white,),
                  onPressed: widget.addAction,
                ),
              ),

            _search
                ? Container()
              : widget.showSearch ? Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff150A42),),
                height: 40,
                width: 40,
                child: IconButton(splashColor: Colors.white.withOpacity(0.5), icon: Icon(Icons.search, color: Colors.white,),
                  onPressed: (){
                    setState(() {
                      _search = true;
                    });
                  },
                ),
              ) : Container()
            ],
          )
        ],
        ),
    );
  }
}