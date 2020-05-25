import 'package:flutter/material.dart';

class SearchInputBox extends StatelessWidget {
  final String label;
  final Widget prefixIcon;
  final Function onChanged;
  final TextInputType keyboardType;
  SearchInputBox({@required this.label, this.prefixIcon, this.onChanged, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width * 0.8) - 10,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        autofocus: true,
        onChanged: onChanged,
        cursorColor: Color(0xff150A42),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff150A42), width: 2, style: BorderStyle.solid)
          ),
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
