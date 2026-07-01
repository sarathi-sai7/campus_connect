class CommunityModel {

  final String id;

  final String name;

  final String description;

  final String category;

  final String image;

  final String createdBy;

  final DateTime createdAt;

  final bool isOfficial;

  final List<String> members;

  final int membersCount;

  // =========================
  // NEW GOVERNANCE FIELDS
  // =========================

  final String head;

  final List<String> coHeads;

  final List<String> admins;

  final List<String> moderators;

  final bool approvalRequired;

  CommunityModel({

    required this.id,

    required this.name,

    required this.description,

    required this.category,

    required this.image,

    required this.createdBy,

    required this.createdAt,

    required this.isOfficial,

    required this.members,

    required this.membersCount,

    // NEW

    required this.head,

    required this.coHeads,

    required this.admins,

    required this.moderators,

    required this.approvalRequired,
  });

  // =========================
  // FROM MAP
  // =========================

  factory CommunityModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return CommunityModel(

      id:
          map["id"] ?? "",

      name:
          map["name"] ?? "",

      description:
          map["description"] ?? "",

      category:
          map["category"] ?? "",

      image:
          map["image"] ?? "",

      createdBy:
          map["createdBy"] ?? "",

      createdAt:

          map["createdAt"] != null

              ? map["createdAt"]
                  .toDate()

              : DateTime.now(),

      isOfficial:
          map["isOfficial"] ??
              false,

      members:
          List<String>.from(
        map["members"] ?? [],
      ),

      membersCount:
          map["membersCount"] ??
              0,

      // =========================
      // NEW GOVERNANCE FIELDS
      // =========================

      head:
          map["head"] ?? "",

      coHeads:
          List<String>.from(
        map["coHeads"] ?? [],
      ),

      admins:
          List<String>.from(
        map["admins"] ?? [],
      ),

      moderators:
          List<String>.from(
        map["moderators"] ?? [],
      ),

      approvalRequired:
          map["approvalRequired"] ??
              true,
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {

    return {

      "id": id,

      "name": name,

      "description":
          description,

      "category":
          category,

      "image": image,

      "createdBy":
          createdBy,

      "createdAt":
          createdAt,

      "isOfficial":
          isOfficial,

      "members": members,

      "membersCount":
          membersCount,

      // =========================
      // NEW GOVERNANCE FIELDS
      // =========================

      "head": head,

      "coHeads":
          coHeads,

      "admins":
          admins,

      "moderators":
          moderators,

      "approvalRequired":
          approvalRequired,
    };
  }
}