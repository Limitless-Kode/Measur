import 'dart:io';
import 'package:measur/methods/stringConstants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;


  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "measur.db";

    //open or create database
    var dbRef = await openDatabase(path, version: 1, onCreate: _createTables);
    return dbRef;
  }

  void _createTables(Database db, int version) async{
    String projects_sql = "CREATE TABLE projects("
        "$PROJECT_ID VARCHAR(255) NOT NULL PRIMARY KEY,"
        "$CUSTOMER_ID VARCHAR(255) NOT NULL,"
        "$PROJECT_TITLE VARCHAR(255) NOT NULL,"
        "$TOTAL_COST DOUBLE NOT NULL,"
        "$AMOUNT_PAID DOUBLE NOT NULL,"
        "$COMPLETED NUMERIC DEFAULT 0,"
        "$TASKS_COMPLETED NUMERIC DEFAULT 0,"
        "$START_DATE DATETIME NOT NULL,"
        "$END_DATE DATETIME NOT NULL,"
        "$SYNC NUMERIC DEFAULT 0"
        ")";

    String tasks_sql = "CREATE TABLE tasks("
        "$ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$PROJECT_ID VARCHAR(255),"
        "$TASK_TITLE VARCHAR(255) NOT NULL,"
        "$TASK_STATE NUMERIC DEFAULT 0,"
        "$TASK_DATE DATETIME NOT NULL,"
        "$START_TIME DATETIME NOT NULL,"
        "$END_TIME DATETIME NOT NULL,"
        "$PRIORITY NUMERIC DEFAULT 0,"
        "$SYNC NUMERIC DEFAULT 0,"
        "CONSTRAINT fk_project "
        "FOREIGN KEY ($PROJECT_ID) "
        "REFERENCES projects($PROJECT_ID)"
        ")";

    String dressmaker_sql = "CREATE TABLE dressmakers("
        "$DRESSMAKER_ID VARCHAR(255) PRIMARY KEY NOT NULL,"
        "$EMAIL VARCHAR(100) UNIQUE NOT NULL,"
        "$PHONE VARCHAR(13) UNIQUE NOT NULL,"
        "$FULL_NAME VARCHAR(255) NOT NULL"
        ")";


    String customer_sql = "CREATE TABLE customers("
        "$CUSTOMER_ID VARCHAR(255) NOT NULL PRIMARY KEY UNIQUE,"
        "$FULL_NAME VARCHAR(255) NOT NULL,"
        "$PHONE VARCHAR(13) NOT NULL UNIQUE,"
        "$ADDRESS VARCHAR(255) NOT NULL,"
        "$GENDER VARCHAR(15) NOT NULL,"
        "$ARMHOLE DOUBLE DEFAULT NULL,"
        "$ACROSS_BACK DOUBLE DEFAULT NULL,"
        "$ACROSS_CHEST DOUBLE DEFAULT NULL,"
        "$CHEST DOUBLE DEFAULT NULL,"
        "$BACK_BODY_LENGTH DOUBLE DEFAULT NULL,"
        "$FRONT_BODY_LENGTH DOUBLE DEFAULT NULL,"
        "$BICEP DOUBLE DEFAULT NULL,"
        "$CROTCH DOUBLE DEFAULT NULL,"
        "$CUFF DOUBLE DEFAULT NULL,"
        "$CUP_SIZE DOUBLE DEFAULT NULL,"
        "$DRESS_LENGTH DOUBLE DEFAULT NULL,"
        "$HEAD_CIRCUMFERENCE DOUBLE DEFAULT NULL,"
        "$HEEL DOUBLE DEFAULT NULL,"
        "$HEIGHT DOUBLE DEFAULT NULL,"
        "$HIP DOUBLE DEFAULT NULL,"
        "$INSEAM DOUBLE DEFAULT NULL,"
        "$OUTSEAM DOUBLE DEFAULT NULL,"
        "$LONG_SLEEVE_LENGTH DOUBLE DEFAULT NULL,"
        "$NECK_CIRCUMFERENCE DOUBLE DEFAULT NULL,"
        "$QTR_SLEEVE_CIRCUMFERENCE DOUBLE DEFAULT NULL,"
        "$QTR_SLEEVE_LENGTH DOUBLE DEFAULT NULL,"
        "$SHORT_SLEEVE_LENGTH DOUBLE DEFAULT NULL,"
        "$SHOULDER DOUBLE DEFAULT NULL,"
        "$THIGH DOUBLE DEFAULT NULL,"
        "$WAIST DOUBLE DEFAULT NULL,"
        "$WRIST_CIRCUMFERENCE DOUBLE DEFAULT NULL,"
        "$DATE_ADDED DATETIME DEFAULT TIMESTAMP,"
        "$ACROSS_SHOULDER_FRONT DOUBLE DEFAULT NULL,"
        "$ACROSS_SHOULDER_BACK DOUBLE DEFAULT NULL,"
        "$BAND_HEIGHT DOUBLE DEFAULT NULL,"
        "$BUST DOUBLE DEFAULT NULL,"
        "$BUST_POINT DOUBLE DEFAULT NULL,"
        "$BUST_SPAN DOUBLE DEFAULT NULL,"
        "$KNEE_CIRCUMFERENCE DOUBLE DEFAULT NULL,"
        "$NAPE_TO_WAIST DOUBLE DEFAULT NULL,"
        "$SHOULDER_TO_FLOOR DOUBLE DEFAULT NULL,"
        "$SHOULDER_TO_HIP DOUBLE DEFAULT NULL,"
        "$SHOULDER_TO_KNEE DOUBLE DEFAULT NULL,"
        "$UNDER_BUST_CIRCUMFERENCE DOUBLE DEFAULT NULL,"
        "$UNDER_BUST_LENGTH DOUBLE DEFAULT NULL,"
        "$WAIST_TO_ANKLE DOUBLE DEFAULT NULL,"
        "$WAIST_TO_FLOOR DOUBLE DEFAULT NULL,"
        "$WAIST_TO_HIP DOUBLE DEFAULT NULL,"
        "$WAIST_TO_KNEE DOUBLE DEFAULT NULL,"
        "$SYNC NUMERIC DEFAULT 0"
        ")";


    await db.execute(dressmaker_sql);
    await db.execute(customer_sql);
    await db.execute(projects_sql);
    await db.execute(tasks_sql);
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }
}