class CommentModel {
  String? uId;
  String? name;
  String? userImage;
  Map<String, dynamic>? commentImage;
  DateTime? dateTime;
  String? commentText;

  CommentModel({
    this.uId,
    this.name,
    this.userImage,
    this.commentImage,
    this.dateTime,
    this.commentText,
  });

  CommentModel.fromJson(Map<String, dynamic>? json)
      : this(
          uId: json!['uId'],
          name: json['name'],
          userImage: json['userImage'],
          commentImage: json['commentImage'],
          commentText: json['comment'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
        );

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'userImage': userImage,
      'commentImage': commentImage,
      'dateTime': dateTime!.millisecondsSinceEpoch,
      'comment': commentText,
    };
  }
}
