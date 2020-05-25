import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/pageParts/customers.part.dart';
import 'package:measur/pageParts/projects.part.dart';
import 'package:measur/pageParts/tasks.part.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMethods firebaseMethods = FirebaseMethods();
  PageController pageController = PageController(initialPage: 1);
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.deepOrange,
      color: Color(0xff150A42),
      height: 70,
      animationDuration: Duration(milliseconds: 500),
      animationCurve: Curves.ease,
      index: pageIndex,
      items: <Widget>[
        Icon(Icons.equalizer, size: 30, color: Colors.white,),
        Icon(Icons.dvr, size: 30, color: Colors.white,),
        Icon(Icons.people_outline, size: 30, color: Colors.white,),
      ],
      onTap: (index) {
        pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
        setState(() {
          pageIndex = index;
        });
    },
  ),
      body: SafeArea(
              child: Container(
          child: PageView(
            controller: pageController,
            onPageChanged: (index){
              setState(() {
                pageIndex = index;
              });
            },
            children: <Widget>[
              Tasks(),
              Projects(),
              Customers()
            ],
          ),
        ),
      )
      );
  }
}