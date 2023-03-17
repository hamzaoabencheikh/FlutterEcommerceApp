class UserModel {
  UserModel({
    required this.userid,
    required this.username,
    required this.password,
    required this.email,
    required this.birthdate,
    required this.address,
    required this.postalcode,
    required this.city,
  });

  String userid;
  String username;
  String password;
  String email;
  String birthdate;
  String address;
  String postalcode;
  String city;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userid: json["userid"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        birthdate: json["birthdate"] ?? '',
        address: json["address"] ?? '',
        postalcode: json["postalcode"] ?? '',
        city: json["city"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": username,
        "password": password,
        "email": email,
        "birthdate": birthdate,
        "address": address,
        "postalcode": postalcode,
        "city": city,
      };
}
