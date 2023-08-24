class LikesModel {
  String uId;
  String name;
  String image;
  String bio;
  String cover;
  String email;
  String phone;
  DateTime dateTime;

  LikesModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.bio,
    required this.cover,
    required this.email,
    required this.phone,
    required this.dateTime,
  });

  LikesModel.fromJson(Map<String, dynamic> json)
      : this(
          uId: json['uId'],
          name: json['name'],
          image: json['image'],
          bio: json['bio'],
          cover: json['cover'],
          email: json['email'],
          phone: json['phone'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'image': image,
      'bio': bio,
      'cover': cover,
      'email': email,
      'phone': phone,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }
}
