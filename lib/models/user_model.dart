class UserModel {
  String? email;
  String? name;
  String? phone;
  String? password;
  String? uId;
  bool? isEmailVerified;

  UserModel(this.email, this.name, this.phone, this.password, this.uId,this.isEmailVerified);

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }

   Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
