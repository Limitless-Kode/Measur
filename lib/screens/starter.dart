import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:measur/widgets/StarterSlide.dart';

class Starter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: LiquidSwipe(
          slideIconWidget: Container(child: Icon(Icons.arrow_back_ios, color: Colors.white,),),
          enableLoop: true,
          enableSlideIcon: true,
          positionSlideIcon: 0.04,
          //onPageChangeCallback: (page)=> print(page),
          pages: <Container>[
            Container(
              child: StarterSlide(
                index: 1,
                imagePath: "resources/images/1.jpg",
                screenHeight: height,
                title: "Classic Finishing",
                description: "Increase productivity and deliver at a great quality. Take your dress making to another level.",
                onPressed: ()=> null,
              ),
            ),
            Container(
              child: StarterSlide(
                index: 2,
                imagePath: "resources/images/2.jpg",
                screenHeight: height,
                title: "Beat Timelines",
                description: "Track your progress and be reminded of your delivery date. Speed up to beat the timeline and take time to rest.",
                onPressed: ()=> null,
              ),
            ),
            Container(
              child: StarterSlide(
                index: 3,
                imagePath: "resources/images/3.jpg",
                screenHeight: height,
                title: "Create Moments",
                description: "Create Moments with your creativity and get your clients send you praise everyday. Step up your Game with Measur",
                onPressed: ()=> Navigator.pushReplacementNamed(context, "/auth"),
                label: "Get Started",
              ),
            ),
          ],
        )
        ),
    );
  }
}