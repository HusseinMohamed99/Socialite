class PostModel {
  String? name;
  String? uId;
  String? postId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  int? likes;
  int? comments;

  PostModel({
    this.uId,
    this.dateTime,
    this.name,
    this.postImage,
    this.image,
    this.text,
    this.likes,
    this.comments,
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    dateTime = json['dateTime'];
    name = json['name'];
    text = json['text'];
    image = json['image'];
    postImage = json['postImage'];
    likes = json['likes'];
    comments = json['comments'];
    postId = json['postId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'name': name,
      'text': text,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'likes': likes,
      'comments': comments,
      'postId': postId,
    };
  }
}
