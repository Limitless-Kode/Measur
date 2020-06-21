import 'package:measur/methods/stringConstants.dart';

class Customer{
  String gender;
  String fullName;
  String phone;
  String address;
  double shoulder;
  double acrossShoulderFront;
  double acrossShoulderBack;
  double neckCircumference;
  double napeToWaist;
  double headCircumference;
  double cupSize;
  double chest;
  double acrossChest;
  double acrossBack;
  double acrossShoulder;
  double bust;
  double bustPoint;
  double bustSpan;
  double underBustLength;
  double underBustCircumference;
  double waist;
  double frontBodyLength;
  double backBodyLength;
  double hip;
  double thigh;
  double inseam;
  double outSeam;
  double shoulderToHip;
  double shoulderToKnee;
  double shoulderToFloor;
  double waistToHip;
  double waistToKnee;
  double waistToAnkle;
  double waistToFloor;
  double kneeCircumference;
  double cuff;
  double heel;
  double crotch;
  double bandHeight;
  double height;
  double bicep;
  double shortSleeveLength;
  double qtrSleeveLength;
  double qtrSleeveCircumference;
  double longSleeveLength;
  double wristCircumference;
  double armhole;
  double dressLength;
  DateTime dateAdded;
  List<String> dressmakers;

  Customer(
      {this.gender,
      this.fullName,
      this.phone,
      this.address,
      this.shoulder,
      this.acrossShoulderFront,
      this.acrossShoulderBack,
      this.neckCircumference,
      this.napeToWaist,
      this.headCircumference,
      this.cupSize,
      this.chest,
      this.acrossChest,
      this.acrossBack,
      this.acrossShoulder,
      this.bust,
      this.bustPoint,
      this.bustSpan,
      this.underBustLength,
      this.underBustCircumference,
      this.waist,
      this.frontBodyLength,
      this.backBodyLength,
      this.hip,
      this.thigh,
      this.inseam,
      this.outSeam,
      this.shoulderToHip,
      this.shoulderToKnee,
      this.shoulderToFloor,
      this.waistToHip,
      this.waistToKnee,
      this.waistToAnkle,
      this.waistToFloor,
      this.kneeCircumference,
      this.cuff,
      this.heel,
      this.crotch,
      this.bandHeight,
      this.height,
      this.bicep,
      this.shortSleeveLength,
      this.qtrSleeveLength,
      this.qtrSleeveCircumference,
      this.longSleeveLength,
      this.wristCircumference,
      this.armhole,
      this.dressLength,
      this.dateAdded,
      this.dressmakers
      });

  Map toMapFemale(Customer customer){
    final data = Map<String, dynamic>();
    data["gender"] = customer.gender;
    data["full_name"] = customer.fullName;
    data["phone"] = customer.phone;
    data["address"] = customer.address;
    data["shoulder"] = customer.shoulder;
    data["across_shoulder_front"] = customer.acrossShoulderFront;
    data["across_shoulder_back"] = customer.acrossShoulderBack;
    data["neck_circumference"] = customer.neckCircumference;
    data["nape_to_waist"] = customer.napeToWaist;
    data["head_circumference"] = customer.headCircumference;
    data["cup_size"] = customer.cupSize;
    data["across_chest"] = customer.acrossChest;
    data["across_back"] = customer.acrossBack;
    data["bust"] = customer.bust;
    data["bust_point"] = customer.bustPoint;
    data["bust_span"] = customer.bustSpan;
    data["under_bust_length"] = customer.underBustLength;
    data["under_bust_circumference"] = customer.underBustCircumference;
    data["waist"] = customer.waist;
    data["waist_to_hip"] = customer.waistToHip;
    data["waist_to_knee"] = customer.waistToKnee;
    data["waist_to_ankle"] = customer.waistToAnkle;
    data["waist_to_floor"] = customer.waistToFloor;
    data["dress_length"] = customer.dressLength;
    data["front_body_length"] = customer.frontBodyLength;
    data["back_body_length"] = customer.backBodyLength;
    data["hip"] = customer.hip;
    data["thigh"] = customer.thigh;
    data["inseam"] = customer.inseam;
    data["outSeam"] = customer.outSeam;
    data["shoulder_to_hip"] = customer.shoulderToHip;
    data["shoulder_to_knee"] = customer.shoulderToKnee;
    data["shoulder_to_floor"] = customer.shoulderToFloor;
    data["knee_circumference"] = customer.kneeCircumference;
    data["band_height"] = customer.bandHeight;
    data["cuff"] = customer.cuff;
    data["heel"] = customer.heel;
    data["crotch"] = customer.crotch;
    data["bicep"] = customer.bicep;
    data["short_sleeve_length"] = customer.shortSleeveLength;
    data["qtr_sleeve_length"] = customer.qtrSleeveLength;
    data["qtr_sleeve_circumference"] = customer.qtrSleeveCircumference;
    data["long_sleeve_length"] = customer.longSleeveLength;
    data["wrist_circumference"] = customer.wristCircumference;
    data["armhole"] = customer.armhole;
    data["date_added"] = customer.dateAdded;
    data["dressmakers"] = customer.dressmakers;

    return data;
  }

  Map toMapMale(Customer customer){
    final data = Map<String, dynamic>();
    data["gender"] = customer.gender;
    data["full_name"] = customer.fullName;
    data["phone"] = customer.phone;
    data["address"] = customer.address;
    data["shoulder"] = customer.shoulder;
    data["neck_circumference"] = customer.neckCircumference;
    data["head_circumference"] = customer.headCircumference;
    data["cup_size"] = customer.cupSize;
    data["chest"] = customer.chest;
    data["across_chest"] = customer.acrossChest;
    data["across_back"] = customer.acrossBack;
    data["waist"] = customer.waist;
    data["dress_length"] = customer.dressLength;
    data["front_body_length"] = customer.frontBodyLength;
    data["back_body_length"] = customer.backBodyLength;
    data["hip"] = customer.hip;
    data["thigh"] = customer.thigh;
    data["inseam"] = customer.inseam;
    data["outSeam"] = customer.outSeam;
    data["cuff"] = customer.cuff;
    data["heel"] = customer.heel;
    data["crotch"] = customer.crotch;
    data["height"] = customer.height;

    data["bicep"] = customer.bicep;
    data["short_sleeve_length"] = customer.shortSleeveLength;
    data["qtr_sleeve_length"] = customer.qtrSleeveLength;
    data["qtr_sleeve_circumference"] = customer.qtrSleeveCircumference;
    data["long_sleeve_length"] = customer.longSleeveLength;
    data["wrist_circumference"] = customer.wristCircumference;
    data["armhole"] = customer.armhole;
    data["dressmakers"] = customer.dressmakers;

    return data;
  }

  Map toFemaleMeasurement(Map customer){
    final data = Map<String, dynamic>();
    data["shoulder"] = customer[SHOULDER];
    data["across_shoulder_front"] = customer[ACROSS_SHOULDER_FRONT];
    data["across_shoulder_back"] = customer[ACROSS_SHOULDER_BACK];
    data["neck_circumference"] = customer[NECK_CIRCUMFERENCE];
    data["nape_to_waist"] = customer[NAPE_TO_WAIST];
    data["head_circumference"] = customer[HEAD_CIRCUMFERENCE];
    data["cup_size"] = customer[CUP_SIZE];
    data["across_chest"] = customer[ACROSS_CHEST];
    data["across_back"] = customer[ACROSS_BACK];
    data["bust"] = customer[BUST];
    data["bust_point"] = customer[BUST_POINT];
    data["bust_span"] = customer[BUST_SPAN];
    data["under_bust_length"] = customer[UNDER_BUST_LENGTH];
    data["under_bust_circumference"] = customer[UNDER_BUST_CIRCUMFERENCE];
    data["waist"] = customer[WAIST];
    data["waist_to_hip"] = customer[WAIST_TO_HIP];
    data["waist_to_knee"] = customer[WAIST_TO_KNEE];
    data["waist_to_ankle"] = customer[WAIST_TO_ANKLE];
    data["waist_to_floor"] = customer[WAIST_TO_FLOOR];
    data["dress_length"] = customer[DRESS_LENGTH];
    data["front_body_length"] = customer[FRONT_BODY_LENGTH];
    data["back_body_length"] = customer[BACK_BODY_LENGTH];
    data["hip"] = customer[HIP];
    data["thigh"] = customer[THIGH];
    data["inseam"] = customer[INSEAM];
    data["outSeam"] = customer[OUTSEAM];
    data["shoulder_to_hip"] = customer[SHOULDER_TO_HIP];
    data["shoulder_to_knee"] = customer[SHOULDER_TO_KNEE];
    data["shoulder_to_floor"] = customer[SHOULDER_TO_FLOOR];
    data["knee_circumference"] = customer[KNEE_CIRCUMFERENCE];
    data["band_height"] = customer[BAND_HEIGHT];
    data["cuff"] = customer[CUFF];
    data["heel"] = customer[HEEL];
    data["crotch"] = customer[CROTCH];
    data["bicep"] = customer[BICEP];
    data["short_sleeve_length"] = customer[SHORT_SLEEVE_LENGTH];
    data["qtr_sleeve_length"] = customer[QTR_SLEEVE_LENGTH];
    data["qtr_sleeve_circumference"] = customer[QTR_SLEEVE_CIRCUMFERENCE];
    data["long_sleeve_length"] = customer[LONG_SLEEVE_LENGTH];
    data["wrist_circumference"] = customer[WRIST_CIRCUMFERENCE];
    data["armhole"] = customer[ARMHOLE];

    return data;
  }

  Map toMaleMeasurement(Map customer){
    final data = Map<String, dynamic>();
    data["shoulder"] = customer[SHOULDER];
    data["neck_circumference"] = customer[NECK_CIRCUMFERENCE];
    data["head_circumference"] = customer[HEAD_CIRCUMFERENCE];
    data["cup_size"] = customer[CUP_SIZE];
    data["chest"] = customer[CHEST];
    data["across_chest"] = customer[ACROSS_CHEST];
    data["across_back"] = customer[ACROSS_BACK];
    data["waist"] = customer[WAIST];
    data["dress_length"] = customer[DRESS_LENGTH];
    data["front_body_length"] = customer[FRONT_BODY_LENGTH];
    data["back_body_length"] = customer[BACK_BODY_LENGTH];
    data["hip"] = customer[HIP];
    data["thigh"] = customer[THIGH];
    data["inseam"] = customer[INSEAM];
    data["outSeam"] = customer[OUTSEAM];
    data["cuff"] = customer[CUFF];
    data["heel"] = customer[HEEL];
    data["crotch"] = customer[CROTCH];
    data["height"] = customer[HEIGHT];
    data["bicep"] = customer[BICEP];
    data["short_sleeve_length"] = customer[SHORT_SLEEVE_LENGTH];
    data["qtr_sleeve_length"] = customer[QTR_SLEEVE_LENGTH];
    data["qtr_sleeve_circumference"] = customer[QTR_SLEEVE_CIRCUMFERENCE];
    data["long_sleeve_length"] = customer[LONG_SLEEVE_LENGTH];
    data["wrist_circumference"] = customer[WRIST_CIRCUMFERENCE];
    data["armhole"] = customer[ARMHOLE];

    return data;
  }
}