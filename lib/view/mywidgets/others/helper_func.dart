import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

LatLng latlonParse(String loc) {
  var splited = loc.split(',');

  return LatLng(double.parse(splited[0]), double.parse(splited[1]));
}


String dateToString(Timestamp? t){
  var date =t!.toDate();
  
  return date.toIso8601String().split('T')[0];
}