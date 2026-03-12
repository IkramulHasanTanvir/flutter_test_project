class PostModelData {
  int? id;
  String? title;
  String? body;
  List<String>? tags;
  Reactions? reactions;
  int? views;
  int? userId;

  PostModelData({
    this.id,
    this.title,
    this.body,
    this.tags,
    this.reactions,
    this.views,
    this.userId,
  });

  PostModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    tags = json['tags'].cast<String>();
    reactions = json['reactions'] != null
        ?  Reactions.fromJson(json['reactions'])
        : null;
    views = json['views'];
    userId = json['userId'];
  }
}

class Reactions {
  int? likes;
  int? dislikes;

  Reactions({this.likes, this.dislikes});

  Reactions.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    dislikes = json['dislikes'];
  }
}
