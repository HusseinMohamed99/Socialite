class PostModel {

  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  String? postID;
  // List<String> postLikes = [];



  PostModel(
      { this.uId,
        this.dateTime,
        this.name,
        this.postImage,
        this.image,
        this.text,
        this.postID,
        // required this.postLikes,
      });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    dateTime = json['dateTime'];
    name = json['name'];
    text = json['text'];
    image = json['image'];
    postImage = json['postImage'];
    postID = json['postID'];
    // postLikes = (json['postLikes'] != null ? List<String>.from(json['postLikes']) : null)!;




  }
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'name': name,
      'text': text,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'postID': postID,
      // 'postLikes': postLikes.map((e) => e.toString()).toList(),
    };
  }
}
