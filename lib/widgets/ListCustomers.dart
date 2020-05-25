import 'package:flutter/material.dart';
import 'package:measur/pageParts/customerDetails.part.dart';
import 'package:measur/widgets/customerCard.dart';
import 'package:measur/widgets/notFound.dart';

class ListCustomers extends StatelessWidget {
  List customers;
  bool loading;

  ListCustomers({this.customers, this.loading = true});

  @override
  Widget build(BuildContext context) {
    if(loading) return Center(
      child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(strokeWidth: 1, )
      ),
    );
    else if(customers.length == 0) return NotFound(description: "You have no Customers presently. You can proceed to add one",callback: ()=> Navigator.pushNamed(context, "/addCustomer"));
    else return Container(
      child: ListView(
        children: customers.map((customer) => CustomerCard(
          name: customer["full_name"],
          phone: customer["phone"],
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context){
                Map newCustomer = Map<String, dynamic>.from(customer);
                return CustomerDetails(customer: newCustomer);
              },
            ));
          },
        )).toList(),
      ),
    );
  }
}
