class MessageModel {
  String? messageId;
  String? senderId;
  String? receiverId;
  DateTime? dateTime;
  String? text;
  String? messageImage;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.messageId,
    this.messageImage,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : this(
          senderId: json['senderId'],
          receiverId: json['receiverId'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
          text: json['text'],
          messageId: json['messageId'],
          messageImage: json['messageImage'],
        );
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
      'messageId': messageId,
      'messageImage': messageImage,
    };
  }
}
