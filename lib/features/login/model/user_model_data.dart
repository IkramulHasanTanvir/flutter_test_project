class UserModelData {
  String? accessToken;
  String? refreshToken;
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;


  String get fullUserName => '$firstName $lastName';


  UserModelData(
      {this.accessToken,
        this.refreshToken,
        this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.gender,
        this.image});

  UserModelData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
  }
}
