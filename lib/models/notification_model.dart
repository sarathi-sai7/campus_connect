class NotificationModel {

  final String id;

  final String userId;

  final String title;

  final String message;

  final String type;

  final bool isRead;

  final String relatedId;

  final DateTime createdAt;

  NotificationModel({

    required this.id,

    required this.userId,

    required this.title,

    required this.message,

    required this.type,

    required this.isRead,

    required this.relatedId,

    required this.createdAt,
  });

  // =========================
  // FROM MAP
  // =========================

  factory NotificationModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return NotificationModel(

      id:
          map["id"] ?? "",

      userId:
          map["userId"] ?? "",

      title:
          map["title"] ?? "",

      message:
          map["message"] ?? "",

      type:
          map["type"] ?? "",

      isRead:
          map["isRead"] ?? false,

      relatedId:
          map["relatedId"] ?? "",

      createdAt:

          map["createdAt"] != null

              ? map["createdAt"]
                  .toDate()

              : DateTime.now(),
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {

    return {

      "id": id,

      "userId": userId,

      "title": title,

      "message": message,

      "type": type,

      "isRead": isRead,

      "relatedId": relatedId,

      "createdAt": createdAt,
    };
  }
}