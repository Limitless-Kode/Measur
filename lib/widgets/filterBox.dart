import 'package:flutter/material.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/widgets/InputBox.dart';

class FilterBox extends StatefulWidget {
  final List suggestedList;
  final Function(String filter) setCustomer;
  final String label;
  final bool enabled;

  FilterBox({@required this.suggestedList, this.setCustomer, @required this.label, this.enabled = false});

  @override
  _FilterBoxState createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  List filteredData = List();
  TextEditingController controller;
  String filterParam;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      child: Column(
        children: <Widget>[
          InputBox(
            enabled: widget.enabled,
            vMargin: 0,
            controller: controller,
            prefixIcon: !widget.enabled
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 18, width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.orange),
                    )
            ),
                  ],
                )
                :Icon(Icons.person),
            label: widget.label,
            onChanged: (value){
                if(value.trim() != ""){
                  setState(() {
                    filterParam = value;
                    filteredData = widget.suggestedList.where((data) => (data["full_name"].toLowerCase()
                        .contains(value.toLowerCase())
                        || data["phone"].toLowerCase()
                        .contains(value.toLowerCase())
                    )).toList();
                  });
                }else{
                  setState(() {
                    filterParam = value;
                    filteredData = null;
                  });
                }
                },
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 80),
            child: Card(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredData == null ? 0 : filteredData.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        filterParam = filteredData[index]["full_name"];
                      });
                      controller.text = filterParam;
                      widget.setCustomer(filteredData[index][CUSTOMER_ID]);
                      filteredData = null;
                    },
                    child: ListTile(
                      title: Text(filteredData[index]["full_name"]),
                      subtitle: Text(filteredData[index]["phone"]),
                    ),
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }
}
