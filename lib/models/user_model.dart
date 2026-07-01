class UserModel {

  final String uid;

  final String name;

  final String email;

  final String department;

  final String semester;

  final String role;

  final String registerNo;

  final bool isOfficialStudent;

  final String profileImage;

  final List<String> joinedClubs;

  final List<String> joinedCommunities;

  final List<String> activities;

  // =========================
  // NEW REALTIME STATUS FIELDS
  // =========================

  final bool isOnline;

  final bool isTyping;

  final String currentCommunity;

  final DateTime? lastSeen;

  UserModel({

    required this.uid,

    required this.name,

    required this.email,

    required this.department,

    required this.semester,

    required this.role,

    required this.registerNo,

    required this.isOfficialStudent,

    required this.profileImage,

    required this.joinedClubs,

    required this.joinedCommunities,

    required this.activities,

    // =========================
    // NEW FIELDS
    // =========================

    required this.isOnline,

    required this.isTyping,

    required this.currentCommunity,

    required this.lastSeen,
  });

  // =========================
  // FROM MAP
  // =========================

  factory UserModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return UserModel(

      uid:
          map['uid'] ?? "",

      name:
          map['name'] ?? "",

      email:
          map['email'] ?? "",

      department:
          map['department'] ?? "",

      semester:
          map['semester'] ?? "",

      role:
          map['role'] ?? "guest",

      registerNo:
          map['registerNo'] ?? "",

      isOfficialStudent:
          map['isOfficialStudent'] ?? false,

      profileImage:
          map['profileImage'] ?? "",

      joinedClubs:
          List<String>.from(

        map['joinedClubs'] ?? [],
      ),

      joinedCommunities:
          List<String>.from(

        map['joinedCommunities'] ?? [],
      ),

      activities:
          List<String>.from(

        map['activities'] ?? [],
      ),

      // =========================
      // NEW REALTIME STATUS
      // =========================

      isOnline:
          map['isOnline'] ?? false,

      isTyping:
          map['isTyping'] ?? false,

      currentCommunity:
          map['currentCommunity'] ?? "",

      lastSeen:

          map['lastSeen']?.toDate(),
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {

    return {

      'uid': uid,

      'name': name,

      'email': email,

      'department': department,

      'semester': semester,

      'role': role,

      'registerNo': registerNo,

      'isOfficialStudent':
          isOfficialStudent,

      'profileImage':
          profileImage,

      'joinedClubs':
          joinedClubs,

      'joinedCommunities':
          joinedCommunities,

      'activities':
          activities,

      // =========================
      // NEW REALTIME STATUS
      // =========================

      'isOnline': isOnline,

      'isTyping': isTyping,

      'currentCommunity':
          currentCommunity,

      'lastSeen': lastSeen,
    };
  }

  // =========================
  // COPY WITH
  // =========================

  UserModel copyWith({

    String? uid,

    String? name,

    String? email,

    String? department,

    String? semester,

    String? role,

    String? registerNo,

    bool? isOfficialStudent,

    String? profileImage,

    List<String>? joinedClubs,

    List<String>? joinedCommunities,

    List<String>? activities,

    bool? isOnline,

    bool? isTyping,

    String? currentCommunity,

    DateTime? lastSeen,
  }) {

    return UserModel(

      uid: uid ?? this.uid,

      name: name ?? this.name,

      email: email ?? this.email,

      department:
          department ??
              this.department,

      semester:
          semester ??
              this.semester,

      role: role ?? this.role,

      registerNo:
          registerNo ??
              this.registerNo,

      isOfficialStudent:
          isOfficialStudent ??
              this.isOfficialStudent,

      profileImage:
          profileImage ??
              this.profileImage,

      joinedClubs:
          joinedClubs ??
              this.joinedClubs,

      joinedCommunities:
          joinedCommunities ??
              this.joinedCommunities,

      activities:
          activities ??
              this.activities,

      // =========================
      // NEW FIELDS
      // =========================

      isOnline:
          isOnline ??
              this.isOnline,

      isTyping:
          isTyping ??
              this.isTyping,

      currentCommunity:
          currentCommunity ??
              this.currentCommunity,

      lastSeen:
          lastSeen ??
              this.lastSeen,
    );
  }
}