class BloodRequest {
  String reason;
  String blood;
  String bloodDescription;
  String location;
  String requester;

  BloodRequest(
      {required this.reason,
      required this.blood,
      required this.bloodDescription,
      required this.location,
      required this.requester});

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'blood': blood,
      'bloodDescription': bloodDescription,
      'location': location,
      'requester':requester
    };
  }

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
        reason: json['reason'],
        blood: json['blood'],
        bloodDescription: json['bloodDescription'],
        location: json['location'],
        requester:json['requester']);
  }
}
