class UserModel {
  final String email;
  final String phone;
  final String name;
  final String uId;
  final String token;
  final String image;
  final String cover;
  final String bio;
  final String portfolio;
  final bool? isEmailVerified;

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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
  }

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
