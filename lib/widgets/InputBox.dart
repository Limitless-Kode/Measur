import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String label;
  final Widget prefixIcon;
  final Function onChanged;
  final TextInputType keyboardType;
  final double vMargin;
  final TextEditingController controller;
  final Function onTap;
  final bool readOnly;
  final double width;
  final bool enabled;
  InputBox({this.enabled = true,this.width, this.readOnly = false,this.onTap, @required this.label, this.prefixIcon, this.onChanged, this.keyboardType = TextInputType.text, this.vMargin = 15, this.controller});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: this.width == null ? width * 0.8 : this.width,
      margin: EdgeInsets.symmetric(vertical: vMargin),
      child: TextField(
        enabled: enabled,
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        onChanged: onChanged,
        cursorColor: Color(0xff150A42),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
          ),
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          labelStyle: TextStyle(fontSize: 18),
          labelText: label,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
          ),

        ),
      ),
    );
  }
}
