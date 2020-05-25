import 'package:flutter/material.dart';
import 'package:measur/widgets/InputBox.dart';

class FemaleInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          InputBox(
            label: "Shoulder",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Neck Circumference",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Head Circumference",
            keyboardType: TextInputType.number,
          ),

          //For Females
          InputBox(
            label: "Cup Size",
            keyboardType: TextInputType.number,
          ),

          InputBox(
            label: "Across Chest",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Across Back",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Chest",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Waist",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Dress Length",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Front Body Length",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Back Body Length",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Hip",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Thigh",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Inseam",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Out Seam",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Height",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Cuff",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Heel",
            keyboardType: TextInputType.number,
          ),
          InputBox(
            label: "Crotch",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
