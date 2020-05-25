import 'package:flutter/cupertino.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/models/Customer.dart';


class CustomerProvider with ChangeNotifier{
  FirebaseMethods firebaseMethods = FirebaseMethods();
  SQLiteMethods _sqLiteMethods = SQLiteMethods();


  CustomerProvider(){
    getCustomers();
  }

  List _customers = [];
  List get customers => _customers;
  bool customersLoading = true;

  getCustomers() async{
    _customers = await _sqLiteMethods.getCustomers();
    customersLoading = false;
    notifyListeners();
  }

  addCustomer(Customer customer) async{
    await _sqLiteMethods.newCustomer(customer);
    await getCustomers();
    notifyListeners();
  }

  updateMeasurement(){

  }
}