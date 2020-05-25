import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateExt{

  static int compare({DateTime initialDate, DateTime otherDate}){
    int days;
    if(initialDate.year == otherDate.year && initialDate.month == otherDate.month)
      days = otherDate.day - initialDate.day;
    else days = -1;

    return days;
  }

  static bool endDateIsPast({String dateTime}){
    DateTime timeDate = DateTime.parse(dateTime);
    DateTime date = DateTime.now();
    bool yearIsNotPast = timeDate.year >= date.year;
    bool monthIsNotPast = timeDate.month >= date.month;
    bool dayIsNotPast = timeDate.day >= date.day;

    if(yearIsNotPast && monthIsNotPast && (dayIsNotPast || (timeDate.month > date.month))) return false;
    return true;
  }

  static bool endTimeIsPast({Timestamp timestamp}){
    TimeOfDay endTime = TimeOfDay.fromDateTime(timestamp.toDate());
    TimeOfDay time = TimeOfDay.fromDateTime(DateTime.now());

    if((time.hour >= endTime.hour && time.minute > endTime.minute)
        || (time.hour > endTime.hour && time.minute >= endTime.minute)) return true;
    else return false;
  }

}