class ChatMessageModel {

  final String id;

  final String senderId;

  final String senderName;

  final String message;

  final DateTime createdAt;

  ChatMessageModel({

    required this.id,

    required this.senderId,

    required this.senderName,

    required this.message,

    required this.createdAt,
  });

  // =========================
  // FROM MAP
  // =========================

  factory ChatMessageModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return ChatMessageModel(

      id:
          map["id"] ?? "",

      senderId:
          map["senderId"] ?? "",

      senderName:
          map["senderName"] ?? "",

      message:
          map["message"] ?? "",

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

      "senderId": senderId,

      "senderName":
          senderName,

      "message": message,

      "createdAt":
          createdAt,
    };
  }
}