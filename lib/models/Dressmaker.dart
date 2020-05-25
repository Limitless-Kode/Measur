class Dressmaker{
  String dressmaker_id;
  String email;
  String phone;
  String fullName;
  String password;


  Dressmaker({this.dressmaker_id, this.email, this.phone, this.fullName, this.password});

  toMap(){
    final map = Map<String, dynamic>();
    map["dressmaker_id"] = dressmaker_id;
    map["email"] = email;
    map["phone"] = phone;
    map["full_name"] = fullName;
    map["password"] = password;

  return map;
}

}