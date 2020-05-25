import 'package:measur/models/Response.dart';

class ValidateForm{
  Future<Response> validatePersonalInfo({fullName, phone, address}) async{
    Response response = Response();
    response.error = false;
    final phoneRegExp = RegExp(r"^[0-9]{10,13}$");
    final fullNameRegExp = RegExp(r"^[A-z]{2,}\s[A-z]{2,}\s?[A-z]{2,}\s?[A-z]{2,}$");
    final addressRegExp = RegExp(r"(\w+){2,}");

    try{
      if(!phoneRegExp.hasMatch(phone)){
        response.error = true;
        response.message = "Please enter a valid phone number";
        return response;
      }
      if(!fullNameRegExp.hasMatch(fullName)){
        response.error = true;
        response.message = "Please enter surname, first and last name";
        return response;
      }
      if(!addressRegExp.hasMatch(address)){
        response.error = true;
        response.message = "Please enter a valid address";
        return response;
      }
      return response;
    }catch(error){
      response.error = true;
      response.message = "Personal Information fields are required";
      return response;
    }

  }
}