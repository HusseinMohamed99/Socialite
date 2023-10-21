class UserModel {
  late String email;
  late String phone;
  late String name;
  late String uId;
  late String token;
  late String image;
  late String cover;
  late String bio;
  late String portfolio;
  late bool? isEmailVerified;

  UserModel({
    this.uId = '',
    this.token = '',
    required this.phone,
    required this.name,
    required this.email,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
    this.portfolio = '',
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          uId: json['uId'],
          token: json['token'],
          email: json['email'],
          name: json['name'],
          phone: json['phone'],
          image: json['image'],
          cover: json['cover'],
          bio: json['bio'],
          isEmailVerified: json['isEmailVerified'],
          portfolio: json['portfolio'],
        );

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'token': token,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      'portfolio': portfolio,
    };
  }
}
