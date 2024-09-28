class UsefulLink {
  String? title;
  String? organization;
  String? about;
  String? webLink;
  String? email;
  String? address;
  String? phoneNo;
  String? imageLink;

  UsefulLink({
    this.title,
    this.organization,
    this.about,
    this.webLink,
    this.email,
    this.address,
    this.phoneNo,
    this.imageLink
  });

  factory UsefulLink.fromJson(Map<String, dynamic> json) {
    return UsefulLink(
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      about: json['about'] ?? '',
      webLink: json['webLink'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      imageLink: json['imageLink']??''
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'title':title??'',
      'organization':organization??'',
      'about':about??'',
      'webLink':webLink??'',
      'email':email??'',
      'address':address??'',
      'phoneNo':phoneNo??'',
      'imageLink':imageLink??''
    };
  }
}
