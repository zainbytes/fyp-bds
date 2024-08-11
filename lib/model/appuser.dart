class AppUser {
  String fullName;
  String email;
  String phoneNo;
  String bloodGroup;
  String bloodDescription;

  AppUser({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.bloodGroup,
    required this.bloodDescription,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        fullName: json['fullName'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        bloodGroup: json['bloodGroup'],
        bloodDescription: json['bloodDescription']);
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'bloodGroup': bloodGroup,
      'bloodDescription': bloodDescription
    };
  }
}
