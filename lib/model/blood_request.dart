class BloodRequest {
  String reason;
  String blood;
  String bloodDescription;
  String location;
  String requester;
  String status;
  String requestCode;
  String donor;

  BloodRequest(
      {required this.reason,
      required this.blood,
      required this.bloodDescription,
      required this.location,
      required this.requester,
      required this.status,
      required this.requestCode,
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
        donor: json['donor']);
  }
}
