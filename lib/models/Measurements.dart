class Measurements{
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


  Map mapMeasurements(Map map){
    map.remove("gender");
    map.remove("full_name");
    map.remove("phone");
    map.remove("address");
    print(map.keys.toString());

    return map;
  }

  Measurements(
      {
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
        this.dateAdded
      });

  Map toMapFemale(Measurements customer){
    var data = Map<String, dynamic>();
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

    return data;
  }







  Map toMapMale(Measurements customer){
    var data = Map<String, dynamic>();
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
    return data;
  }
}