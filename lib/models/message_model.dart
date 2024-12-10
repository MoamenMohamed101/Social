class MessageModel {
  String? senderId, receiverId, text, dateTime;

  MessageModel({
    this.dateTime,
    this.text,
    this.receiverId,
    this.senderId,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderId = json['senderId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
