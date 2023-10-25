class StoryModel {
  String? name;
  String? uId;
  String? image;
  String? storyImage;
  DateTime? dateTime;
  String? text;

  StoryModel(
      {this.uId,
      this.name,
      this.image,
      this.text,
      this.dateTime,
      this.storyImage});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      name: json['name'],
      uId: json['uId'],
      image: json['image'],
      storyImage: json['storyImage'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      text: json['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'storyImage': storyImage,
      'dateTime': dateTime!.millisecondsSinceEpoch,
    };
  }
}
