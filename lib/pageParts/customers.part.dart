import 'package:flutter/material.dart';
import 'package:measur/providers/CustomerProvider.dart';
import 'package:measur/widgets/ListCustomers.dart';
import 'package:measur/widgets/customHeader.dart';
import 'package:provider/provider.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {

  String currentUserID;
  String searchQuery = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CustomHeader(title:"Customers", addAction: ()=> Navigator.pushNamed(context, "/addCustomer"), onChanged: (value){
            setState(() {
              searchQuery = value;
            });
          }),
          Expanded(
              child: Consumer<CustomerProvider>(
                builder: (context, customerProvider, _) => ListCustomers(customers: customerProvider.customers,loading: customerProvider.customersLoading,)
              )
          )
        ],
      ),
    );
  }

}

