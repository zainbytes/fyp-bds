import 'package:cloud_firestore/cloud_firestore.dart';

class BloodRequest {
  String reason;
  String blood;
  String bloodDescription;
  String location;
  String requester;
  String status;
  String requestCode;
  String donor;
  Timestamp createdOn;
  Timestamp? completedOn;

  BloodRequest(
      {required this.reason,
      required this.blood,
      required this.bloodDescription,
      required this.location,
      required this.requester,
      required this.status,
      required this.requestCode,
      required this.createdOn,
      this.completedOn,
      required this.donor,});

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'blood': blood,
      'bloodDescription': bloodDescription,
      'location': location,
      'requester':requester,
      'status':status,
      'requestCode':requestCode,
      'createdOn':createdOn,
      'completedOn':completedOn,
      'donor':donor
    };
  }

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
        reason: json['reason'],
        blood: json['blood'],
        bloodDescription: json['bloodDescription'],
        location: json['location'],
        requester:json['requester'],
        status:json['status'],
        requestCode:json['requestCode'],
        createdOn:json['createdOn']??Timestamp.now(),
        completedOn:json['completedOn'],
        donor: json['donor']);
  }
}
