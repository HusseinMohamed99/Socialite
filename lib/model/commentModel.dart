class CommentModel
{
  String?uId;
  String? name;
  String? image;
  String? dateTime;
  String? comment;
  String? commentImage;


  CommentModel ({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
    this.comment,
    this.commentImage,
  });

  CommentModel .fromJson(Map<String, dynamic> json){
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    comment = json['comment'];
    dateTime = json['dateTime'];
    commentImage = json['commentImage'];
  }

  Map<String, dynamic> toMap (){
    return {
      'uId' : uId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'commentImage':commentImage,
      'comment':comment,

    };
  }
}