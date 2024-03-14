import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  // year
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String date = dateTime.day.toString();
  String hour = dateTime.hour.toString();
  String min = dateTime.minute.toString();
  String time = 'am';

  if (int.parse(hour) > 12) {
    time = "pm";
  }

  String formattedDate = "$date/$month/$year $hour:$min $time ";

  return formattedDate;
}
