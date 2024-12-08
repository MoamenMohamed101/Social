class PostModel {
  String? name, image, uId, dateTime, text, postImage;

  PostModel({
    this.text,
    this.name,
    this.dateTime,
    this.postImage,
    this.image,
    this.uId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    name = json['name'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateTime': dateTime,
      'postImage': postImage,
      'name': name,
      'image': image,
      'uId': uId,
    };
  }
}