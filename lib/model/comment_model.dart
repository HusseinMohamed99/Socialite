class CommentModel {
  String? uId;
  String? name;
  String? userImage;
  Map<String, dynamic>? commentImage;
  String? dateTime;
  String? commentText;

  CommentModel({
    this.uId,
    this.name,
    this.userImage,
    this.commentImage,
    this.dateTime,
    this.commentText,
  });

  CommentModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['uId'];
    name = json['name'];
    userImage = json['userImage'];
    commentImage = json['commentImage'];
    commentText = json['comment'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'userImage': userImage,
      'commentImage': commentImage,
      'dateTime': dateTime,
      'comment': commentText,
    };
  }
}
