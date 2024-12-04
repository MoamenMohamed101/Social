class UserModel {
  String? email,name,phone,password,image,uId,bio,cover;
  bool? isEmailVerified;

  UserModel(
    this.email,
    this.name,
    this.phone,
    this.password,
    this.image,
    this.bio,
    this.cover,
    this.uId,
    this.isEmailVerified,
  );

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'image': image,
      'bio': bio,
      'cover': cover,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
