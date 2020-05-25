import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/Customer.dart';
import 'package:measur/models/Dressmaker.dart';
import 'package:measur/models/Project.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/utils/database_helper.dart';

class SQLiteMethods{
  DatabaseHelper _databaseHelper = DatabaseHelper();
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<Response> newDressmaker(Dressmaker dressmaker) async{
    final db = await _databaseHelper.database;
    Response response = Response();

    if(await _firebaseMethods.isConnected()){
      try{
        Response createdUserResponse = await _firebaseMethods.createUser(dressmaker.fullName, email: dressmaker.email, password: dressmaker.password);

        if(!createdUserResponse.error){
          String uid = await _firebaseMethods.signIn(email: dressmaker.email, password: dressmaker.password);
          if(uid != null){
           //insert dressmakers information into sqlite database
            dressmaker.dressmaker_id = uid;
            Map newDressmaker = dressmaker.toMap();
            newDressmaker.remove("password");

            await _firebaseMethods.addDressMaker(dressmaker, uid);
            await db.insert("dressmakers", newDressmaker);
            return response;
          }else{
            response.error = true;
            response.message = "Something, wrong happened. Please try again!";
            return response;
          }
        }
        return createdUserResponse;
      }catch(err){
        response.error = false;
        response.message = err.message;
        return response;
      }
    }else{
      response.error = true;
      response.message = "No internet connectivity";
      return response;
    }

  }

  Future<Response> newCustomer(Customer customer) async {
    Response response = Response();
    final db = await _databaseHelper.database;
    Map<String, dynamic> _customer;
    Map<String, dynamic> SQLcustomer;

    customer.dateAdded = DateTime.now();

    customer.dressmakers = [await getDressmakerId()];

    //check for gender before map
    if(customer.gender == "male"){
      _customer = customer.toMapMale(customer);
    }
    else{
      _customer = customer.toMapFemale(customer);
    }

    SQLcustomer = Map<String, dynamic>.from(_customer);


    if(await _firebaseMethods.isConnected()){
      if(!await _firebaseMethods.doesUserExist(_customer["phone"])) {
        DocumentReference doc = await _firebaseMethods.addCustomer(_customer);
        SQLcustomer[SYNC] = 1;
        SQLcustomer[CUSTOMER_ID] = doc.documentID;

        //add to database
        SQLcustomer.remove("dressmakers");
        SQLcustomer[DATE_ADDED] = DateTime.now().toString();
        await db.insert("customers", SQLcustomer);
      }
    }else{
      SQLcustomer[SYNC] = 0;
      SQLcustomer[CUSTOMER_ID] = "";
      SQLcustomer.remove("dressmakers");
      SQLcustomer[DATE_ADDED] = DateTime.now().toString();
      await db.insert("customers", SQLcustomer);
    }

    return response;
  }

  Future<Response> newProject(Project project) async{
    final db = await _databaseHelper.database;
    Response response = Response();
    project.dressmaker = await getDressmakerId();
    Map<String, dynamic> projectData = project.toMap(project);
    projectData["tasks_completed"] = 0;
    projectData["completed"] = false;
    projectData["tasks"] = [];

    if(await _firebaseMethods.isConnected()){
      DocumentReference doc = await _firebaseMethods.addProject(projectData);
      projectData[PROJECT_ID] = doc.documentID;

      projectData[SYNC] = 1;
      projectData[START_DATE] = project.startDate.toString();
      projectData[END_DATE] = project.endDate.toString();
      projectData["completed"] = 0;
      projectData.remove(DRESSMAKER);
      projectData.remove("tasks");
      await db.insert("projects", projectData);
    }else{
      projectData[SYNC] = 0;
      await db.insert("projects", projectData);
    }

    response.message = "Project has been added";
    return response;
  }

  Future<Response> updateProject(bool isNumber, String key, String value, String uid) async{
    var parsedValue;

    //check if value is a number or a string and assign the appropriate value
    isNumber ? parsedValue = double.parse(value) : parsedValue = value;

    final db = await _databaseHelper.database;
    Response response = Response();
    String formattedKey = key.trim().split(" ").join("_").toLowerCase();

    if(await _firebaseMethods.isConnected()){
      String sql = isNumber ? "UPDATE projects SET $formattedKey = $parsedValue, $SYNC = 1 WHERE $PROJECT_ID = '$uid' "
      : "UPDATE projects SET $formattedKey = '$parsedValue', $SYNC = 1 WHERE $PROJECT_ID = '$uid' ";
      await db.rawQuery(sql);
      await _firebaseMethods.updateProject(formattedKey, parsedValue, uid);

      response.message = "$key has been updated";
      response.error = false;

    }else{

    }

    return response;
  }

  newTask(Map<String,dynamic> task) async{
    final db = await _databaseHelper.database;
    var response = await db.insert("tasks", task);
    return response;
  }

  getDressmaker() async {
    final db = await _databaseHelper.database;
    var dressmaker = await  db.query("dressmakers");
    return dressmaker;
  }

  //destructive
  deleteAllProjects() async{
    final db = await _databaseHelper.database;
    await db.delete("projects");
    deleteAllTasks();
  }
  deleteAllTasks() async{
    final db = await _databaseHelper.database;
    await db.delete("tasks");
  }
//end of destructive

  getProjects() async{
    final db = await _databaseHelper.database;
    //var projects = await  db.query("projects");
    String sql = "SELECT *, (SELECT COUNT(*) FROM tasks T WHERE T.$PROJECT_ID=P.$PROJECT_ID ) AS tasks FROM projects P ORDER BY $PROJECT_TITLE ASC";
    var projects = await  db.rawQuery(sql);
    return projects;
  }

  getTasks() async{
    final db = await _databaseHelper.database;
    String sql = "SELECT * FROM tasks";
    var tasks = await  db.rawQuery(sql);
    return tasks;
  }


  getCustomers() async{
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> customersList = await db.query("customers ORDER BY full_name ASC");
    return customersList;
  }

  Future<Response> updateMeasurement(key, value, customer_id) async{
    Response response = Response();
    final db = await _databaseHelper.database;
    if(await _firebaseMethods.isConnected()){
      response = await _firebaseMethods.updateMeasurement(key, value, customer_id);
      await db.rawUpdate("UPDATE customers SET $key = value, $SYNC = 1 WHERE $CUSTOMER_ID = $customer_id");
    }else{
      await db.rawUpdate("UPDATE customers SET $key = value, $SYNC = 0 WHERE $CUSTOMER_ID = $customer_id");
    }

  }

  Future<String> getDressmakerId() async{
    List<Map<String, dynamic>> dressmaker = await getDressmaker();
    String id = dressmaker[0][DRESSMAKER_ID];
    return id;
  }

}