class ForumPostModel {

  final String id;

  final String title;

  final String content;

  final String createdBy;

  final String authorName;

  final String category;

  final DateTime createdAt;

  final List<String> likes;

  final int commentsCount;

  ForumPostModel({

    required this.id,

    required this.title,

    required this.content,

    required this.createdBy,

    required this.authorName,

    required this.category,

    required this.createdAt,

    required this.likes,

    required this.commentsCount,
  });

  // =========================
  // FROM MAP
  // =========================

  factory ForumPostModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return ForumPostModel(

      id:
          map["id"] ?? "",

      title:
          map["title"] ?? "",

      content:
          map["content"] ?? "",

      createdBy:
          map["createdBy"] ?? "",

      authorName:
          map["authorName"] ?? "",

      category:
          map["category"] ?? "",

      createdAt:

          map["createdAt"] != null

              ? map["createdAt"]
                  .toDate()

              : DateTime.now(),

      likes:
          List<String>.from(
        map["likes"] ?? [],
      ),

      commentsCount:
          map["commentsCount"] ??
              0,
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {

    return {

      "id": id,

      "title": title,

      "content": content,

      "createdBy":
          createdBy,

      "authorName":
          authorName,

      "category":
          category,

      "createdAt":
          createdAt,

      "likes": likes,

      "commentsCount":
          commentsCount,
    };
  }
}