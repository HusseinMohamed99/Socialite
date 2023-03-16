class UserModel {
  String email;
  String phone;
  String name;
  String uId;
  String image;
  String cover;
  String bio;
  bool isEmailVerified;

  UserModel({
    this.uId = '',
    required this.phone,
    required this.name,
    required this.email,
    required this.image,
    required this.cover,
    required this.bio,
    this.isEmailVerified = false,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          uId: json['uId'],
          email: json['email'],
          name: json['name'],
          phone: json['phone'],
          image: json['image'],
          cover: json['cover'],
          bio: json['bio'],
          isEmailVerified: json['isEmailVerified'],
        );

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
