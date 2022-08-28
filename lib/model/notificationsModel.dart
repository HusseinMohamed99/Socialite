import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
   DateTime? date;
   String? userImage;
   String? userName;
  String? userUid;
   String? event;
  String? postImage;
   String? postId;
   String? notificationType;

  NotificationModel({
     this.userName,
     this.userImage,
    this.userUid,
    this.postImage,
     this.date,
     this.event,
     this.postId,
     this.notificationType,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    date = (json['date'] as Timestamp).toDate();
    userImage = json['userImage'];
    userName = json['userName'];
    userUid = json['userUid'];
    event = json['event'];
    postImage = json['postImage'];
    postId = json['postId'];
    notificationType = json['notificationType'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'userName': userName,
      'userImage': userImage,
      'userUid': userUid,
      'event': event,
      'postImage': postImage,
      'postId': postId,
      'notificationType': notificationType,
    };
  }
}