import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isDisabled;
  final String label;
  final Icon icon;
  final Function onPressed;
  SubmitButton({this.isDisabled = false, @required this.label, this.icon, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      return Container(
          width: width * 0.8,
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 30),
          child: RaisedButton.icon(
            label: Text(label,style: TextStyle(color: Colors.white),),
            icon: icon,
            onPressed: this.isDisabled ? null : onPressed,
            splashColor: Color(0xffffffff).withOpacity(0.3),
            color: Color(0xff150A42),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          )
      );
  }
}