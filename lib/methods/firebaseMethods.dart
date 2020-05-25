import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:measur/methods/stringConstants.dart';
import 'package:measur/models/Dressmaker.dart';
import 'package:measur/models/Response.dart';
import 'package:measur/models/Task.dart';

class FirebaseMethods{
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Response response = Response();

  Future<List> getCustomers() async{
    List response = [];
    String currentUserID = await _auth.currentUser().then((value) => value.uid);
    QuerySnapshot customers = await db.collection(CUSTOMER).where("dressmakers",arrayContains: currentUserID)
    .getDocuments();

    customers.documents.forEach((element){
      Map data;
      data = element.data;
      data["docId"] = element.documentID;
      response.add(data);
    });

    return response;
  }

  Future<Response> updateMeasurement(String key, String value, String uid) async{
    String formattedKey = key.trim().split(" ").join("_").toLowerCase();
    return await db.collection(CUSTOMER).document(uid)
    .updateData({formattedKey: double.parse(value)})
    .then((res){
      response.message = "$key has been updated";
      response.error = false;
      return response;
    }).catchError((error){
      response.message = error.message;
      response.error = true;
      return response;
    });
  }

  updateProject(String key, var value, String uid) async{
    if(key == START_DATE || key == END_DATE) value = DateTime.parse(value);
    await db.collection("projects").document(uid)
        .updateData({key: value});
  }

  Future addTask({projectId, Task task}) async{

      final DocumentReference projectReference = db.collection("projects").document(projectId);
      final DocumentSnapshot projectSnapshot = await projectReference.get();

      List tasks = projectSnapshot.data["tasks"];

      Map data = task.toMap();
      data["state"] = 0;
      data["date_added"] = DateTime.now();
      tasks.add(data);

      //update tasks
      projectReference.updateData({"tasks": tasks});
  }

  Future<DocumentReference> addCustomer(Map customer) async{
      return await db.collection(CUSTOMER).add(customer).then((document){
        return document;
      });
  }

  Future<DocumentReference> addProject(Map project) async{
    return db.collection("projects").add(project)
    .then((document) async{
      return document;
    });
  }

  Future<List<Map<String, dynamic>>> getProjects() async{
    String dressmaker_uid = await _auth.currentUser().then((value) => value.uid);
    Map<String, dynamic> completeProject = {};
    List<Map<String, dynamic>> projectList = [];
    CollectionReference collectionReference = db.collection("projects");


    await collectionReference
        .where("dressmaker", isEqualTo: dressmaker_uid).where("task_count", isGreaterThan: 0)
        .getDocuments().then((projects) async{
          await Future.forEach(projects.documents, (doc) async{
            completeProject = {};

            completeProject["project_id"] = doc.documentID;
            completeProject.addAll(doc.data);

            await collectionReference.document(doc.documentID)
                .collection("milestones")
                .getDocuments().then((milestone){
              milestone.documents.forEach((element) {
                completeProject["milestone_id"] = element.documentID;
                completeProject.addAll(element.data);
              });
            });

            //add data from project to the list of projects
            projectList.add(completeProject);
          });
    });

    return projectList;

  }


  Future<bool> doesUserExist(String phone) async{
    return db.collection(CUSTOMER)
    .where("phone", isEqualTo: phone)
    .getDocuments()
    .then((doc){
      return doc.documents.isNotEmpty;
    });
  }

  Future<bool> isConnected() async{
    bool isConnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }

    return isConnected;
  }

  Future<Response> createUser(fullName,{@required String email, @required String password}) async{
   try{
      if(email == null || email.trim() == ""){
        response.error = true;
        response.message = "Please provide your email!";
        return response;
      }else if(password == null || password.trim() == ""){
        response.error = true;
        response.message = "Please provide a valid password!";
        return response;
      }else{
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
        UserUpdateInfo userInfo = UserUpdateInfo();
        userInfo.displayName = fullName;
        await currentUser.updateProfile(userInfo);
        return response;
      }
    }catch(err){
        response.error = true;
        response.message = err.message;
        return response;
    }
  }
  
  Future<Response> addDressMaker(Dressmaker dressmaker, uid) async{
            return await db.collection("dressmakers")
                .document(uid)
                .setData({"full_name": dressmaker.fullName, "email": dressmaker.email, "phone": dressmaker.phone})
                .then((doc) => response);
  }

  Future<String> signIn({@required String email, @required String password}) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _user = result.user;
      return _user.uid;
    }catch(err){
      return null;
    }
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<bool> foundCurrentUser() async{
    if(await _auth.currentUser() != null){
      return true;
    }
    return false;
  }
}