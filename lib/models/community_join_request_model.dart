class CommunityJoinRequestModel {

  final String id;

  final String communityId;

  final String communityName;

  final String userId;

  final String userName;

  final String userEmail;

  final String reason;

  final String status;

  final DateTime createdAt;

  CommunityJoinRequestModel({

    required this.id,

    required this.communityId,

    required this.communityName,

    required this.userId,

    required this.userName,

    required this.userEmail,

    required this.reason,

    required this.status,

    required this.createdAt,
  });

  // =========================
  // FROM MAP
  // =========================

  factory CommunityJoinRequestModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return CommunityJoinRequestModel(

      id:
          map["id"] ?? "",

      communityId:
          map["communityId"] ?? "",

      communityName:
          map["communityName"] ?? "",

      userId:
          map["userId"] ?? "",

      userName:
          map["userName"] ?? "",

      userEmail:
          map["userEmail"] ?? "",

      reason:
          map["reason"] ?? "",

      status:
          map["status"] ?? "pending",

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

      "communityId":
          communityId,

      "communityName":
          communityName,

      "userId": userId,

      "userName":
          userName,

      "userEmail":
          userEmail,

      "reason": reason,

      "status": status,

      "createdAt":
          createdAt,
    };
  }
}