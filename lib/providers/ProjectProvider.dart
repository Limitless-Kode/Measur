import 'package:flutter/cupertino.dart';
import 'package:measur/methods/sqliteMethods.dart';
import 'package:measur/methods/stringConstants.dart';

class ProjectProvider with ChangeNotifier{
  SQLiteMethods _sqLiteMethods = SQLiteMethods();
  List _projects = [];

  List get projects => _projects;


  ProjectProvider(){
    getProjects();
  }

  deleteProjects() async{
    _projects = await _sqLiteMethods.deleteAllProjects();
    notifyListeners();
  }

  deleteTasks() async{
    _projects = await _sqLiteMethods.deleteAllTasks();
    notifyListeners();
  }

  getProjects() async{
    _projects = await _sqLiteMethods.getProjects();
    notifyListeners();
  }

//  getCompletedProjects(){
//    _completedProjects = _projects.where((element) => element[COMPLETED] == 1).toList();
//    return completedProjects;
//  }
}