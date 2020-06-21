import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/Customer.dart';
import 'package:measur/models/Task.dart';
import 'package:measur/utils/database_helper.dart';

class Synchronization{
  DatabaseHelper _databaseHelper = DatabaseHelper();
  FirebaseMethods firebaseMethods = FirebaseMethods();
  List _customers;
  List _projectsWithTasks;
  List _tasks = [];
  Customer customer;

  download() async{
    _customers = await firebaseMethods.getCustomers();
    _projectsWithTasks = await firebaseMethods.getProjects();
  }

  reinitialize() async{
    await download();
    final db = await _databaseHelper.database;


    Future.wait(_customers.map((customer) async{
      customer[SYNC] = 1;
      customer.remove("dressmakers");
      await db.insert("customers", customer);
    }));

    Future.wait(_projectsWithTasks.map((project) async{
      _tasks.add(project["tasks"]);
      project[SYNC] = 1;
      project[START_DATE] = project[START_DATE].toDate().toString();
      project[END_DATE] = project[END_DATE].toDate().toString();
      project[COMPLETED] = project[COMPLETED] ? 1 : 0;

      project.remove("dressmaker");
      project.remove("tasks");

      await db.insert("projects", project);
    }));

    Future.wait(_tasks.map((loadedTasks) async{
      loadedTasks.map((task) async{
        task[SYNC] = 1;
        task[TASK_DATE] = task[TASK_DATE].toDate().toString();
        task[START_TIME] = task[START_TIME].toDate().toString();
        task[END_TIME] = task[END_TIME].toDate().toString();
        task.remove(DATE_ADDED);
        await db.insert("tasks", task);
      }).toList();
    }));
  }






  initialize() async{
    await updateCustomers();
    await updateProjects();
    await updateTasks();
  }

  Future<List<Map<String,dynamic>>> getCustomers() async{
    final db = await _databaseHelper.database;
    var customers = await db.query("customers", where: "$SYNC = 0");
    return customers;
  }

  Future<List<Map<String,dynamic>>> getProjects() async{
    final db = await _databaseHelper.database;
    var projects = await db.query("projects", where: "$SYNC = 0");
    return projects;
  }

  Future<List<Map<String,dynamic>>> getTasks() async{
    final db = await _databaseHelper.database;
    var tasks = await db.query("tasks", where: "$SYNC = 0");
    //print(tasks);
    return tasks;
  }

  Future updateCustomers() async{
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> customers = await getCustomers();
    customers.forEach((customer) {
      firebaseMethods.addCustomer(customer);
      db.rawUpdate("UPDATE customers SET $SYNC = 1 WHERE $CUSTOMER_ID = '${customer[CUSTOMER_ID]}'");
    });
  }

  Future updateProjects() async{
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> projects = await getProjects();
    projects.forEach((project) {
      firebaseMethods.addProject(project);
      db.rawUpdate("UPDATE projects SET $SYNC = 1 WHERE $PROJECT_ID = '${project[PROJECT_ID]}'");
    });
  }

  Future updateTasks() async{
//    task_title
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> tasks = await getTasks();
    tasks.forEach((task) {
      Task newTask = Task();
      newTask.fromMap(task);
      firebaseMethods.addTask(projectId: task[PROJECT_ID],task: newTask);
      db.rawUpdate("UPDATE tasks SET $SYNC = 1 WHERE $ID = '${task[ID]}'");
    });
  }
}