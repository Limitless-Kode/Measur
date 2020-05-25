import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class StarterSlide extends StatelessWidget {
  final double screenHeight;
  final String imagePath;
  final int index;
  final String title;
  final String description;
  final String label;
  final Function onPressed;


  StarterSlide({Key key, @required this.screenHeight, @required this.imagePath, @required this.index, @required this.title,
  @required this.description, this.label = "Swipe", @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black87, Colors.transparent], begin: Alignment.bottomCenter),
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                alignment: Alignment.centerLeft,
                child: Text(index == null ? "":"#$index",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 46),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                alignment: Alignment.centerLeft,
                child: Text(title,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 36),
                ),
                ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child: Text(description,
                  style: TextStyle(color: Colors.white,height: 1.5, fontSize: 18),
                ),
              ),
              ((){
                return label == "Swipe" ?
                Padding(
                  padding: EdgeInsets.only(bottom: 90, top: 30),
                  child: OutlineButton.icon(
                    onPressed: onPressed,
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    label: Text(label,style: TextStyle(color: Colors.white),),
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.white,
                        width: 2
                    ),
                    hoverColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  ),
                )
                :
                Padding(
                padding: EdgeInsets.only(bottom: 90, top: 30),
                child: OutlineButton(
                onPressed: onPressed,
                child: Text(label,style: TextStyle(color: Colors.white),),
                borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.white,
                width: 2
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                hoverColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 35),
                ),
                );
              }())

            ],
          ),
        )
      ],
    );
  }
}