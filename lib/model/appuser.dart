class AppUser {
  String fullName;
  String email;
  String phoneNo;
  String bloodGroup;
  String? location;

  AppUser({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.bloodGroup,
    this.location,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        fullName: json['fullName'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        bloodGroup: json['bloodGroup'],
        location: json['location']??'');
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'bloodGroup': bloodGroup,
      'location': location
    };
  }
}
