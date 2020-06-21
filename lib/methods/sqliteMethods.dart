import 'package:measur/methods/firebaseMethods.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/Customer.dart';
import 'package:measur/models/Dressmaker.dart';
import 'package:measur/models/Project.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/services/synchronization.service.dart';
import 'package:measur/utils/database_helper.dart';

class SQLiteMethods{
  DatabaseHelper _databaseHelper = DatabaseHelper();
  
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  Synchronization synchronization = Synchronization();

  Future<Response> newDressmaker(Dressmaker dressmaker) async{
    final db = await _databaseHelper.database;
    Response response = Response();

    if(await _firebaseMethods.isConnected()){
      try{
        Response createdUserResponse = await _firebaseMethods.createUser(dressmaker.fullName, dressmaker.phone , email: dressmaker.email, password: dressmaker.password);

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

  Future<Response> setDressmaker() async{
    final db = await _databaseHelper.database;
    Response response = Response();
    Map dressmaker = await _firebaseMethods.getUser();
    await db.insert("dressmakers", dressmaker);
    return response;
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
        _customer[CUSTOMER_ID] = _firebaseMethods.generateId();
        await _firebaseMethods.addCustomer(_customer);
        SQLcustomer[SYNC] = 1;
        SQLcustomer[CUSTOMER_ID] = _customer[CUSTOMER_ID];

        //add to database
        SQLcustomer.remove("dressmakers");
        SQLcustomer[DATE_ADDED] = DateTime.now().toString();
        await db.insert("customers", SQLcustomer);
      }

    }else{
      SQLcustomer[SYNC] = 0;
      SQLcustomer[CUSTOMER_ID] = _firebaseMethods.generateId();
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
    projectData[TASKS_COMPLETED] = 0;
    projectData[COMPLETED] = false;
    projectData["tasks"] = [];

    if(await _firebaseMethods.isConnected()){
      projectData[PROJECT_ID] = _firebaseMethods.generateId();
      await _firebaseMethods.addProject(projectData);

      projectData[SYNC] = 1;
      projectData[START_DATE] = project.startDate.toString();
      projectData[END_DATE] = project.endDate.toString();
      projectData[COMPLETED] = 0;
      projectData.remove(DRESSMAKER);
      projectData.remove("tasks");
      await db.insert("projects", projectData);
    }else{
      String projectID = _firebaseMethods.generateId();
      projectData[PROJECT_ID] = projectID;
      projectData[START_DATE] = project.startDate.toString();
      projectData[END_DATE] = project.endDate.toString();
      projectData[COMPLETED] = 0;
      projectData.remove(DRESSMAKER);
      projectData.remove("tasks");
      projectData[SYNC] = 0;
      await db.insert("projects", projectData);
    }

    response.message = "Project has been added";
    return response;
  }

  Future<Response> setProject(Map project) async{
    final db = await _databaseHelper.database;
    Response response = Response();

    await db.insert("projects", project);

    return response;
  }

  Future<Response> updateProject(bool isNumber, String key, String value, String uid) async{
    var parsedValue;

    //check if value is a number or a string and assign the appropriate value
    isNumber ? parsedValue = double.parse(value) : parsedValue = value;

    final db = await _databaseHelper.database;
    Response response = Response();
    String formattedKey = key.trim().split(" ").join("_").toLowerCase();

    String sql = isNumber ? "UPDATE projects SET $formattedKey = $parsedValue, $SYNC = 0 WHERE $PROJECT_ID = '$uid' "
        : "UPDATE projects SET $formattedKey = '$parsedValue', $SYNC = 0 WHERE $PROJECT_ID = '$uid' ";

    await db.rawQuery(sql);

    if(await _firebaseMethods.isConnected()){
      synchronization.initialize();
    }
    response.message = "$key has been updated";
    response.error = false;

    return response;
  }

  newTask(Map<String,dynamic> task) async{
    final db = await _databaseHelper.database;
    var response = await db.insert("tasks", task);
    return response;
  }

  setTask(Map<String,dynamic> task) async{
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

  Future<Response> updateMeasurement(key, value, customerId) async{
    String formattedKey = key.trim().split(" ").join("_").toLowerCase();
    Response response = Response();

    final db = await _databaseHelper.database;

    await db.rawUpdate("UPDATE customers SET $formattedKey = $value, $SYNC = 0 WHERE $CUSTOMER_ID = '$customerId'");

    if(await _firebaseMethods.isConnected()){
      synchronization.initialize();
    }

    response.message = "$key has been updated";
    return response;
  }

  Future<String> getDressmakerId() async{
    List<Map<String, dynamic>> dressmaker = await getDressmaker();
    String id = dressmaker[0][DRESSMAKER_ID];
    return id;
  }

  Future logout() async{
    await _databaseHelper.deleteDB();
    await _firebaseMethods.signOut();
  }
}