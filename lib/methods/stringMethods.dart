class StringMethods{
  List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  List<String> days = ["MON","TUE","WED","THU","FRI","SAT","SUN"];

  Map<String, dynamic> formatDate({int day, int monthIndex, int year}){
    String month = months[monthIndex - 1];
    String dayStr = day.toString();
    if(day < 10){
      dayStr = "0$dayStr";
    } 
    String date = "$dayStr $month $year";
    return {"month":month, "day":day,"year":year, "date":date};
  }

  Map<String, dynamic> getDate(){
    var dateTime = DateTime.now();
    String date = dateTime.toString().split(" ")[0];
    int month = int.parse(date.split("-")[1]);
    int day = int.parse(date.split("-")[2]);
    int year = int.parse(date.split("-")[0]);

    Map formatedDate = formatDate(monthIndex: month, day: day, year: year);

    return formatedDate;
  }

  String formatKey(String key){
    String str = "";
    key.split("_").forEach((element) {
      str += element[0].toUpperCase() + element.substring(1) + " ";
    });
    return str;
  }
}