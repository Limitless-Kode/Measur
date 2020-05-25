import 'package:flutter/material.dart';
import 'package:measur/providers/NotificationProvider.dart';
import 'package:measur/providers/CustomerProvider.dart';
import 'package:measur/providers/ProjectProvider.dart';
import 'package:measur/providers/TaskProvider.dart';
import 'package:measur/screens/addCustomer.dart';
import 'package:measur/screens/addProject.dart';
import 'package:measur/screens/authenticate.screen.dart';
import 'package:measur/screens/home.screen.dart';
import 'package:measur/screens/loading.screen.dart';
import 'package:measur/screens/starter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider(context)),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff150A42)
        ),
        initialRoute: "/",
        routes: {
          "/": (context)=> Loading(),
          "/starter": (context)=> Starter(),
          "/auth": (context)=> Login(),
          "/home": (context)=> Home(),
          "/addCustomer": (context) => AddCustomer(),
          "/addProject": (context) => AddProject()
        },
      ),
    )
  );
}
